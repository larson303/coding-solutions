# Counting http status codes with a hashmap (dictionary) in Python
def find_most_frequent_status_code(status_codes):
    # Step 1: Initialize an empty dictionary to store counts
    status_count = {}

    # Step 2: Iterate through the status_codes list
    for code in status_codes:
        if code in status_count:
            status_count[code] += 1  # Increment count if code exists
        else:
            status_count[code] = 1   # Add new code with count 1
    
    # Step 3: Find the status code with the maximum count
    # Use max() when you only need the most frequent item.
    most_frequent_code = max(status_count, key=status_count.get)

    # Use sorted() when you want a ranking of all items in descending order.
    # sorted() returns a list of tuples, where each tuple contains the item and its count.
    # The key argument specifies the function to use for sorting with the x[1] indicating the count.
    # The reverse argument specifies whether to sort in ascending or descending order.
    # sorted(status_counnt.items(), key=lambda x: x[1], reverse=True)
    
    return most_frequent_code, status_count[most_frequent_code]

# Input list of status codes
status_codes = [200, 404, 200, 500, 200, 404, 503, 500, 200]

# Call the function and print the result
result = find_most_frequent_status_code(status_codes)
print(f"The most frequent status code is {result[0]} with {result[1]} occurrences.")