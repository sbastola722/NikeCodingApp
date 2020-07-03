# NikeCodingApp
This app is built using XCode 11.4.1 and Swift 5. 
Swift 5's Result type is used for networking.

1. Leveraged Dynamic Cell Sizing and StackView in Album Table View for the following reasons:
    * To make sure both the image and the the text stack view (containing both album and artist name labels) are vertically centered in the cell.
    * If the album name or artist name or both are too long, then the cell would resize to ensure that none of text is truncated and the image will still be vertically centered in the cell.
    * If in case artist name or album name is missing, hiding the corresponding label will make sure the remaining text will move up or down to be vertically centered in the cell.
2. Used Vertical StackView in the Album Detail View for following reasons:
    * If some of the information in the middle section such as (Genre or Release Date) is missing, then the missing label is hidden.
    * In such case, StackView then automatically moves the rest of the content up to fill up what would have otherwise been an empty space.
3. Wrote a generic network router stack to perform network operations.
4. Performed following unit tests:
    * Networking tests using expectations
    * Mock tests to convert mock json files to album model objects for these scenarios: valid json, invalid json, json with no albums
    * Error messages to be displayed to end user
    * Converting release date from the API to user friendly dates
    * Test coverage is ~68%
