# FileExporter + Transferable Bug

Filed an issue via Feedback Assistant: FB20928477

You can [watch a demo](https://x.com/LiYanan2004/status/1986095794106282186?s=20) on Twitter.

Starts from macOS 26.1 (i didn't testing other aligning OS, iOS 26.1, etc.)

### Related API

- [`SwiftUICore.View.fileExporter(isPresented:item:contentTypes:defaultFilename:onCompletion:onCancellation:)`](https://developer.apple.com/documentation/swiftui/view/fileexporter(ispresented:item:contenttypes:defaultfilename:oncompletion:oncancellation:))

### Description

Transferable type can’t be exported via `fileExporter(isPresented:item:contentTypes:defaultFilename:onCompletion:onCancellation:)` API

I am using `FileRepresentation`. The intermediate file export (via Transferable protocol) is working, and the file does export to the destination.

But from user side, he/she selected a final path to save the exported document — SwiftUI fails to move intermediate file to user selection path

- intermediate file exported
- `SentTransferredFile` created
- user selected a final path
- SwiftUI FAILS to move intermediate path to final path
   - throwing an error: “No such file”
   - it’s using caches path + file name + file extension, not the exact one from `SentTransferredFile`

I also tried to specify `intermediateURL` to caches folder as we see in the error log, however it still produces this error with a file name that suffix a uuid added behind.

![](/Resources/demo2.gif)