import ballerina/io;

function main (string... args) {
    string path = "sample.json";
    io:ByteChannel byteChannel = io:openFile(untaint path, io:READ);
    io:CharacterChannel ch = new io:CharacterChannel(byteChannel, "UTF8");

    json|error result = ch.readJson();

    json bookStore;
    match result {
        json j => {
            bookStore = j;
        }
        error e => {
            io:println("error occured while reading the json");
            return;
        }
    }

    bookStore.store.books.foreach((json book) => {
        match book.year {
            int year => {
                if (year > 1900) {
                    io:println(book);
                }
            }
            any a => {
                io:println("incorrect year: ", a);
            }            
        }
    });
}
