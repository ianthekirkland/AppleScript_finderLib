# AppleScript_finderLib  
#### AppleScript Scripting Library for Common Finder Functions  

This library is a collection of common Finder-centric AppleScript subroutines. Many are my own. Many come courtesy of [http://applescript.bratis-lover.net](http://applescript.bratis-lover.net "Brati's Lover"). Some of these subroutines (mostly my contributions) are a bit verbose as I wrote them awhile ago before I delved into programming in things such as PHP, Ruby, and Perl. So if portions feel like "three lefts make a right", know that syntactic elegance was not yet in my vocabulary.
  
  
## Compatibility  

macOS / OS X 10.5+ / Works great on Sierra! Developed and/or used on every Mac OS version since Leopard. Uncompiled versions (i.e. with file extension "applescript") included.  
  
  
## Installation  

Download or clone the file to `~/Library/Script Libraries`. If the `Script Libraries` folder doesn't exist in your library folder, simply create it.
  
  
## Usage  

Once the file is in the `Script Libraries` folder, you can use any of the subroutines (or "handlers") in your script by loading this library with the `load script` command (see below) or the `use` command.

```applescript
-- Load library
set _finderLib to load script alias ((path to home folder as text) & "Library:Script Libraries:" & "AppleScript_finderLib.scpt")
```
  
Then, you're all set! Call any of the library's functions like this (for example):  
```applescript
tell _finderLib
  set _items to getSelection()
  set _basenames to getBasenamesOfOnlyFiles(_items)
end tell
```
  
You can also cut to the chase by nesting functions.  
```applescript
tell _finderLib to set _firstSelectedItemBasename to getBasenameOfItem( getFirstItem( getSelection( )))
```

For a full list of all the functions, and to demonstrate the above, a starter script in 2 formats, [Quick_Start_File (uncompiled)](https://github.com/ianthekirkland/AppleScript_finderLib/Quick_Start_File.applescript "Quick_Start_File") and [Quick_Start_File (compiled)](https://github.com/ianthekirkland/AppleScript_finderLib/Quick_Start_File.scpt "Quick_Start_File"), is included. It contains a call to every subroutine/function in the library, so you can get a sense of what's available. In addition, all subroutines are listed below:

```applescript  
getSelection( )
--->  {item, item, item, ...}
```
```applescript  
getOnlyFiles( items )
--->  {file, file, file, ...}
```
```applescript  
getOnlyFolders( items )
--->  {folder, folder, folder, ...}
```
```applescript  
getFirstItem( items )
--->  item
```
```applescript  
getNames( items )
--->  {fullname, fullname, fullname, ...}
```
```applescript  
getBasenames( items )
--->  {basename, basename, basename, ...}
```
```applescript  
getBasenameOfFirstItem( items )
--->  basename
```
```applescript  
getBasenamesOfOnlyFiles( items )
--->  {basename, basename, basename, ...}
```
```applescript  
getExtensions( items )
--->  {extension, extension, [null], ...}
```
```applescript  
getExtensionsOfOnlyFiles( items )
--->  {extension, extension, extension, ...}
```
```applescript  
toggleExtensionsHidden( items )
--->  (shows/hides extensions)
```
```applescript  
getPosixPaths( items )
--->  {POSIX path, POSIX path, POSIX path, ...}
```
```applescript  
getPosixPathsQ( items )
--->  {'POSIX path', 'POSIX path', 'POSIX path', ...}
```
```applescript  
getEscapedPosixArray( items )
--->  "(EscapedPOSIXpath EscapedPOSIXpath EscapedPOSIXpath ...)"
```
```applescript  
getHFSPaths( items )
--->  {HFS path, HFS path, HFS path, ...}
```
```applescript  
getHFSPathsQ( items )
--->  {'HFS path', 'HFS path', 'HFS path', ...}
```
```applescript  
getParentPosix( items )
--->  {parent POSIX path, parent POSIX path, parent POSIX path, ...}
```
```applescript  
getParentHFS( items )
--->  {parent HFS path, parent HFS path, parent HFS path, ...} 
```
```applescript  
getBasenameOfItem( item )
--->  basename
```
```applescript  
getNameAndExt( item )
--->  {name, extension}
```
```applescript  
getCommentOfItem( item )
--->  comment
```
```applescript  
getContainerOfItem( item )
--->  parent folder
```
```applescript  
getPropertiesOfItem( item )
--->  {property:value, property:value, property:value, ...}
```
```applescript  
getParentAlias( alias )
--->  parent alias
```
```applescript  
appendBasenamesToParentPOSIX( basenames, parentPOSIX )
--->  {full POSIX path, full POSIX path, full POSIX path, ...}  
```
