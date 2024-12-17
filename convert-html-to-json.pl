#!/usr/bin/perl
use strict;
use warnings;
use HTML::TreeBuilder;
use JSON;

# Directory containing HTML files
my $directory = "./";  # Current directory; update if needed
opendir(DIR, $directory) or die "Cannot open directory: $!";
my @files = grep { /\.htm$/i } readdir(DIR);
closedir(DIR);

# Output: JSON Data
my @bible_data;
my %book_data;  # Temporary storage to group chapters by books

foreach my $file (sort @files) {
    # Parse HTML
    my $tree = HTML::TreeBuilder->new_from_file($file);

    # Extract book name and chapter number
    my $title = $tree->look_down(_tag => 'title')->as_text;
    $title =~ /^.*? (.+?) (\d+)?$/;  # Extract book name and chapter (if available)
    my $book_name = $1 || 'Unknown';
    my $chapter_number = $2 || 0;

    # Clean book name
    $book_name =~ s/^\s+|\s+$//g;

    # Extract all paragraphs with verses
    my @paragraphs = $tree->look_down(_tag => 'div', class => 'p');
    my @verses;

    foreach my $para (@paragraphs) {
        my @verse_spans = $para->look_down(_tag => 'span', class => 'verse');
        foreach my $verse (@verse_spans) {
            my $verse_num = $verse->attr('id');
            my $verse_text = $verse->parent->as_text;

            # Clean text
            $verse_text =~ s/\s+/ /g;
            $verse_text =~ s/^\d+\s//;

            # Add verse
            push @verses, { verse => $verse_num, text => $verse_text };
        }
    }

    # Organize data into book -> chapters
    push @{$book_data{$book_name}->{chapters}}, {
        chapter_number => $chapter_number,
        verses         => \@verses
    };

    $tree->delete;  # Clean up memory
}

# Assign book indexes and compile into the final structure
my $index = 1;
foreach my $book (sort keys %book_data) {
    push @bible_data, {
        book_index => $index++,
        book_name  => $book,
        chapters   => $book_data{$book}->{chapters}
    };
}

# Convert to JSON and write to a file
my $json_output = to_json(\@bible_data, { pretty => 1 });
open my $fh, '>', 'bible_data.json' or die "Cannot open file: $!";
print $fh $json_output;
close $fh;

print "Data successfully written to bible_data.json\n";

