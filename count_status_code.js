function findMostFrequentStatusCode(statusCodes) {
    const statusCount = {}; // Initialize an empty object as our hash map

    // Count occurrences of each status code
    for (let code of statusCodes) {
        statusCount[code] = (statusCount[code] || 0) + 1;
    }

    // Find the status code with the maximum count
    let mostFrequentCode = null;
    let maxCount = 0;

    for (let code in statusCount) {
        if (statusCount[code] > maxCount) {
            mostFrequentCode = code;
            maxCount = statusCount[code];
        }
    }

    return { mostFrequentCode, maxCount };
}

// Input list of status codes
const statusCodes = [200, 404, 200, 500, 200, 404, 503, 500, 200];

// Call the function and print the result
const result = findMostFrequentStatusCode(statusCodes);
console.log(`The most frequent status code is ${result.mostFrequentCode} with ${result.maxCount} occurrences.`);
