
---------------------------------------------- FINDER LIBRARY ----------------------------------------------
-- Description: This file is a library of common Finder functions
-- Purpose: By loading this library into your script, any of the functions below become available to it
-- How to Use: Load this library by calling it within your script per the example below
-- Example: (Assumes that this library file is at '~/Library/Script Libraries/_FinderLib.scpt')

(*
	set _FinderLib to load script alias  ¬
		((path to scripts folder as text) &  "ScriptLibraries:_FinderLib.scpt")
	tell _FinderLib
		set _result to functionName(_input, _param, _anyOtherParams)
	end tell
*)

-------------------------------------------------------------
property myName : "_FinderLib" ---> (the name of this library)
-------------------------------------------------------------



-------------------------------------------- LIST OF FUNCTIONS --------------------------------------------
(*

getItems( )
#=>  {item, item, item, ...}

getFiles( items )
#=>  {file, file, file, ...}

getFolders( items )
#=>  {folder, folder, folder, ...}

getFirstItem( items )
#=>  item

getNames( items )
#=>  {fullname, fullname, fullname, ...}

getBasenames( items )
#=>  {basename, basename, basename, ...}

getBasenameFirstItem( items )
#=>  basename

getBasenamesFiles( items )
#=>  {basename, basename, basename, ...}

getExtensionsFiles( items )
#=>  {extension, extension, extension, ...}

toggleExtensionsHidden( items )
#=>  (shows/hides extensions)

getPathsPosix( items )
#=>  {POSIX path, POSIX path, POSIX path, ...}

getPathsPosixQ( items )
#=>  {'POSIX path', 'POSIX path', 'POSIX path', ...}

getPathsPosixEsc( items )
#=>  "(EscapedPOSIXpath EscapedPOSIXpath EscapedPOSIXpath ...)"

getPathsHFS( items )
#=>  {HFS path, HFS path, HFS path, ...}

getPathsHFSQ( items )
#=>  {'HFS path', 'HFS path', 'HFS path', ...}

getParentPathPosix( items )
#=>  {parent POSIX path, parent POSIX path, parent POSIX path, ...}

getParentPathHFS( items )
#=>  {parent HFS path, parent HFS path, parent HFS path, ...} 

getParentAlias( alias )
#=>  parent alias

getBasename( item )
#=>  basename

getBasenameAndExtension( item )
#=>  {name, extension}

getBasenameAndExtension_alt( item)
#=> {basename, extension}

getCommentOfItem( item )
#=>  comment

getContainerOfItem( item )
#=>  parent folder

getPropertiesOfItem( item )
#=>  {property:value, property:value, property:value, ...}

joinBasenamesToParentPathPosix( basenames, parentPosix )
#=>  {full POSIX path, full POSIX path, full POSIX path, ...}

*)




------------------------------------------------ FUNCTIONS ------------------------------------------------


----- getItems( ) -----
-- Description: Gets every item of a selection
-- Input: Finder selection
-- Parameters: (none)
-- Result: List of references to Finder items
on getItems()
	tell application "Finder"
		set _sel to the selection
		set _items to every item of _sel
	end tell
	return _items
end getItems





----- getFiles( items ) -----
-- Description: Gets only the non-folder / non-alias files from Finder items
-- Input: Finder items
-- Parameters: (none)
-- Result: List of references to filtered Finder items
on getFiles(_items)
	tell application "Finder"
		set _list to {}
		repeat with _item in _items
			if kind of _item is not "Folder" and kind of _item is not "Alias" then
				set end of _list to _item as alias
			end if
		end repeat
	end tell
	return _list
end getFiles






----- getFolders( items ) -----
-- Description: Gets only the folders from a set of Finder items
-- Input: Finder items
-- Parameters: (none)
-- Result: List of references to Finder folders
on getFolders(_items)
	tell application "Finder"
		set _folders to {}
		repeat with _item in _items
			if kind of _item is "Folder" then
				set end of _folders to _item as alias
			end if
		end repeat
	end tell
	return _folders
end getFolders




----- getFirstItem( items ) -----
-- Description: Get the first item of the Finder items ( items )
-- Input: Finder items
-- Result: first item
on getFirstItem(_items)
	if _items is not {} then
		try
			tell application "Finder"
				repeat with _item in _items
					set _item to item 1 of _items
				end repeat
			end tell
		on error _msg number _n
			beep
			display dialog ¬
				"Oops! Something went wrong: " & {return} & {return} & ¬
				_msg & {return} & "( error code " & _n & " )" with title ("Error") with icon (caution)
			return
		end try
	end if
	return _item
end getFirstItem



----- getNames( items ) -----
-- Description: Get list of selected items' fullnames with extensions ( items )
-- Input: Finder items
-- Result: List of names
on getNames(_items)
	if _items is not {} then
		try
			set _list to {}
			tell application "Finder"
				repeat with _item in _items
					set _fullname to name of _item
					set end of _list to _fullname
				end repeat
			end tell
		on error _msg number _n
			beep
			display dialog ¬
				"Oops! Something went wrong: " & {return} & {return} & ¬
				_msg & {return} & "( error code " & _n & " )" with title ("Error") with icon (caution)
			return
		end try
	end if
	return _list
end getNames



----- getBasenames( items ) -----
-- Description: Get list of items' names ( items )
-- Input: Finder items
-- Result: List of basenames
on getBasenames(_items)
	if _items is not {} then
		try
			set _list to {}
			tell application "Finder"
				repeat with _item in _items
					set _fullname to name of _item
					if name extension of _item is not "" then
						set _here to -(offset of "." in ((reverse of text items of _fullname) as text)) - 1
						set _basename to (text 1 thru _here of _fullname)
						set _basename to (_basename as string)
					else
						set _basename to _fullname
					end if
					set end of _list to _basename
				end repeat
			end tell
		on error _msg number _n
			beep
			display dialog ¬
				"Oops! Something went wrong: " & {return} & {return} & ¬
				_msg & {return} & "( error code " & _n & " )" with title ("Error") with icon (caution)
			return
		end try
	end if
	return _list
end getBasenames



----- getBasenameFirstItem( items ) -----
-- Description: Get name of the first selected items ( items )
-- Input: Finder items
-- Result: basename of first item
on getBasenameFirstItem(_items)
	if _items is not {} then
		try
			tell application "Finder"
				repeat with _item in _items
					set _item to item 1 of _items
					set _fullname to name of _item
					if name extension of _item is not "" then
						set _here to -(offset of "." in ((reverse of text items of _fullname) as text)) - 1
						set _basename to (text 1 thru _here of _fullname)
						set _basename to (_basename as string)
					else
						set _basename to _fullname
					end if
				end repeat
			end tell
		on error _msg number _n
			beep
			display dialog ¬
				"Oops! Something went wrong: " & {return} & {return} & ¬
				_msg & {return} & "( error code " & _n & " )" with title ("Error") with icon (caution)
			return
		end try
	end if
	return _basename
end getBasenameFirstItem





----- getBasenamesFiles( items ) -----
-- Description: Get list of non-folder / non-alias filenames
-- Input: Finder items
-- Result: List of basenames of files (not including folders and aliases)
on getBasenamesFiles(_items)
	if _items is not {} then
		try
			set _list to {}
			tell application "Finder"
				repeat with _item in _items
					if kind of _item is not "Folder" and kind of _item is not "Alias" then
						set _fullname to name of _item
						if name extension of _item is not "" then
							set _here to -(offset of "." in ((reverse of text items of _fullname) as text)) - 1
							set _basename to (text 1 thru _here of _fullname)
							set _basename to (_basename as string)
							set end of _list to _basename
						end if
					end if
				end repeat
			end tell
		on error _msg number _n
			beep
			display dialog ¬
				"Oops! Something went wrong: " & {return} & {return} & ¬
				_msg & {return} & "( error code " & _n & " )" with title ("Error") with icon (caution)
			return
		end try
	end if
	return _list
end getBasenamesFiles





----- getExtensionsFiles( items ) -----
-- Description: Get list of non-folder / non-alias extensions
-- Input: Finder items
-- Result: List of extensions of files (not including folders and aliases)
on getExtensionsFiles(_items)
	if _items is not {} then
		try
			set _list to {}
			tell application "Finder"
				repeat with _item in _items
					if kind of _item is not "Folder" and kind of _item is not "Alias" then
						if name extension of _item is not "" then
							set _ext to name extension of _item
							set end of _list to _ext
						end if
					end if
				end repeat
			end tell
		on error _msg number _n
			beep
			display dialog ¬
				"Oops! Something went wrong: " & {return} & {return} & ¬
				_msg & {return} & "( error code " & _n & " )" with title ("Error") with icon (caution)
			return
		end try
	end if
	return _list
end getExtensionsFiles




----------------------- show / hide extension -----------------------
-- Description: Toggle the visibility of Finder item extensions ( items )
-- Input: Finder item(s)
-- Result: Extensions shown or hidden (returns boolean true on success)
on toggleExtensionsHidden(_items)
	tell application "System Events"
		tell application "Finder"
			repeat with _item in _items
				set _item to _item
				if name extension of _item is not "" then
					set _extHidden to extension hidden of _item
					if _extHidden is false then
						tell _item to set extension hidden to true
					else
						tell _item to set extension hidden to false
					end if
				end if
			end repeat
		end tell
	end tell
	return true
end toggleExtensionsHidden




----- getPathsPosix( items ) -----
-- Description: Get list of items' POSIX paths ( items )
-- Input: Finder items
-- Result: List of POSIX paths
on getPathsPosix(_items)
	if _items is not {} then
		try
			set _list to {}
			tell application "Finder"
				repeat with _item in _items
					set _path to (POSIX path of (_item as alias))
					set end of _list to _path
				end repeat
			end tell
			return _list
		on error _msg number _n
			beep
			display dialog ¬
				"Couldn't get POSIX path: " & {return} & {return} & ¬
				_msg & {return} & "( error code " & _n & " )" with title ("Error") with icon (caution)
		end try
	end if
end getPathsPosix



----- getPathsPosixQ( items ) -----
-- Description: Get list of items' quoted POSIX paths
-- Input: Finder items
-- Result: List of quoted form of POSIX paths
on getPathsPosixQ(_items)
	if _items is not {} then
		try
			set _list to {}
			tell application "Finder"
				repeat with _item in _items
					set _path to (POSIX path of (_item as alias))
					set end of _list to (quoted form of _path)
				end repeat
			end tell
			return _list
		on error _msg number _n
			beep
			display dialog ¬
				"Couldn't get quoted POSIX path: " & {return} & {return} & ¬
				_msg & {return} & "( error code " & _n & " )" with title ("Error") with icon (caution)
		end try
	end if
end getPathsPosixQ



----- getPathsPosixEsc( items ) -----
-- Description: Get shell array of items' escaped POSIX paths
-- Input: Finder items
-- Result: String of [Shell array of escaped form of POSIX paths]
on getPathsPosixEsc(_items)
	tell application "Finder"
		set _list to {}
		set original_delims to AppleScript's text item delimiters
		repeat with _item in _items
			set _path to (POSIX path of (_item as alias))
			set _path to (_path as text)
			set _pathString to {}
			set AppleScript's text item delimiters to " "
			set _escapedSpace to ("\\ " as text)
			repeat with _t in every text item in _path
				set end of _pathString to ((_t & _escapedSpace) as text)
			end repeat
			set AppleScript's text item delimiters to ""
			set _pathString to _pathString as text
			set _pathString to (characters 1 thru -3 of _pathString)
			set _pathString to _pathString as text
			set end of _list to _pathString & " "
		end repeat
		set _list to _list as string
		set _list to text items 1 thru -2 of _list
		set _list to _list as text
		set _shArray to ("(" & _list & ")") as text
		set AppleScript's text item delimiters to original_delims -- {""}
	end tell
	return _shArray
end getPathsPosixEsc



----- getPathsHFS( items ) -----
-- Description: Get list of items' HFS paths ( items )
-- Input: Finder items
-- Result: List of HFS paths
on getPathsHFS(_items)
	if _items is not {} then
		try
			set _list to {}
			tell application "Finder"
				repeat with _item in _items
					set _path to (_item as text)
					set end of _list to _path
				end repeat
			end tell
			return _list
		on error _msg number _n
			beep
			display dialog ¬
				"Couldn't get HFS path: " & {return} & {return} & ¬
				_msg & {return} & "( error code " & _n & " )" with title ("Error") with icon (caution)
		end try
	end if
end getPathsHFS



----- getPathsHFSQ( items ) -----
-- Description: Get list of items' HFS paths ( items )
-- Input: Finder items
-- Result: List of HFS paths
on getPathsHFSQ(_items)
	if _items is not {} then
		try
			set _list to {}
			tell application "Finder"
				repeat with _item in _items
					set _path to (_item as text)
					set end of _list to (quoted form of _path)
				end repeat
			end tell
			return _list
		on error _msg number _n
			beep
			display dialog ¬
				"Couldn't get HFS path: " & {return} & {return} & ¬
				_msg & {return} & "( error code " & _n & " )" with title ("Error") with icon (caution)
		end try
	end if
end getPathsHFSQ



----- getParentPathPosix( items ) -----
-- Description: Get the POSIX path of items' (item 1) parent folder
-- Input: Finder items
-- Result: Parent folder's POSIX path
on getParentPathPosix(_items)
	if _items is not {} then
		try
			tell application "Finder"
				set _container to container of item 1 of (_items)
				set _parent to POSIX path of (_container as string)
			end tell
			return _parent
		on error eMsg number eNum
			error "Can't getParent: " & eMsg number eNum
		end try
	end if
end getParentPathPosix





----- getParentPathHFS( items ) -----
on getParentPathHFS(_items)
	if _items is not {} then
		try
			tell application "Finder"
				set _container to container of item 1 of (_items)
				set _parent to (_container as string)
			end tell
			return _parent
		on error eMsg number eNum
			error "Can't getParent: " & eMsg number eNum
		end try
	end if
end getParentPathHFS





----- getBasename( item )-----
-- Description: Get name of item ( item )
-- Input: Finder item
-- Result: basename of Finder item
on getBasename(_item)
	if _item is not {} and _item is not "" then
		try
			tell application "Finder"
				set _fullname to name of _item
				if name extension of _item is not "" then
					set _here to -(offset of "." in ((reverse of text items of _fullname) as text)) - 1
					set _basename to (text 1 thru _here of _fullname)
					set _basename to (_basename as string)
				else
					set _basename to _fullname
				end if
			end tell
		on error _msg number _n
			beep
			display dialog ¬
				"Oops! Something went wrong: " & {return} & {return} & ¬
				_msg & {return} & "( error code " & _n & " )" with title ("Error") with icon (caution)
			return
		end try
	end if
	return _basename
end getBasename




----------------------- getBasenameAndExtension( item ) -----------------------
-- Description: Get name and file extension of a Finder item
-- Input: Finder item
-- Result: List...{name, extension}
on getBasenameAndExtension(_item)
	set _delimsOld to (AppleScript's text item delimiters)
	set _delimsNew to ("")
	set AppleScript's text item delimiters to (_delimsNew)
	
	tell application "Finder"
		set _name to (name of _item)
		set _nameLength to (length of _name)
		set _ext to (name extension of _item)
		set _extLength to (length of _ext)
		if _extLength is not 0 then
			set _basenameLength to (_nameLength - (_extLength + 1))
			set _basename to ((text items 1 thru _basenameLength) of _name)
			set _basename to (_basename as string)
		else
			set _ext to ("")
			set _extLength to (0)
			set _basename to (_name as string)
		end if
	end tell
	----------------------------------------------
	set _extension to _ext
	set _basename to _basename
	set _nameList to {_basename, _extension}
	return _nameList
	----------------------------------------------
	set AppleScript's text item delimiters to _delimsOld
end getBasenameAndExtension



---------------------------------------------- GET {BASENAME, EXTENSION} ( item ) ----------------------------------------------
on getBasenameAndExtension_alt(_item)
	tell application "System Events"
		tell application "Finder"
			set _path to (POSIX path of (_item as alias))
			if (character -1 of (_item as string) is ":") then ---> is folder
				set _ext to ""
				set _basename to ((name of _item) as string)
			else
				set _ext to _item's name extension
				set _basename to do shell script "basename " & (quoted form of _path) & " " & "." & (quoted form of _ext)
			end if
			set _result to {_basename, _ext}
		end tell
	end tell
end getBasenameAndExtension_alt






----- getCommentOfItem( item )-----
-- Description: Get Spotlight Comment of item ( item )
-- Input: Finder item
-- Result: Spotlight Comment of Finder item
on getCommentOfItem(_item)
	if _item is not {} and _item is not "" then
		try
			tell application "Finder"
				set _comment to comment of _item
			end tell
		on error _msg number _n
			beep
			display dialog ¬
				"Oops! Something went wrong: " & {return} & {return} & ¬
				_msg & {return} & "( error code " & _n & " )" with title ("Error") with icon (caution)
			return
		end try
	end if
	return _comment
end getCommentOfItem




----- getContainerOfItem( item )-----
-- Description: Get Container Folder of item ( item )
-- Input: Finder item
-- Result: Container folder of Finder item
on getContainerOfItem(_item)
	if _item is not {} and _item is not "" then
		try
			tell application "Finder"
				set _container to container of _item
			end tell
		on error _msg number _n
			beep
			display dialog ¬
				"Oops! Something went wrong: " & {return} & {return} & ¬
				_msg & {return} & "( error code " & _n & " )" with title ("Error") with icon (caution)
			return
		end try
	end if
	return _container
end getContainerOfItem




----- getPropertiesOfItem( item )-----
-- Description: Get properties of item as list ( item )
-- Input: Finder item
-- Result: List of Finder item properties
on getPropertiesOfItem(_item)
	try
		tell application "Finder"
			set _properties to properties of _item
		end tell
	on error _msg number _n
		beep
		display dialog ¬
			"Oops! Something went wrong: " & {return} & {return} & ¬
			_msg & {return} & "( error code " & _n & " )" with title ("Error") with icon (caution)
		return
	end try
	return _properties
end getPropertiesOfItem


(*
1.	bounds
2.	comment
3.	container
4.	creation date
5.	creator type
6.	description
7.	desktop position
8.	disk
9.	displayed name
10.	everyones privileges
11.	extension hidden
12.	file type
13.	group
14.	group privileges
15.	icon
16.	index
17.	kind
18.	label index
19.	location
20.	locked
21.	modification date
22.	name
23.	name extension
24.	owner
25.	owner privileges
26.	extension hidden
27.	file type
28.	group
29.	group privileges
30.	icon
31.	index
32.	information window
33.	kind
34.	label index
35.	location
36.	locked
37.	modification date
38.	name
39.	name extension
40.	owner
41.	owner privileges
42.	physical size
43.	position
44.	product version
45.	properties
46.	size
47.	stationery
48.	URL
49.	version
*)






----- getParentAlias( alias ) -----
-- COPYRIGHT (c) 2008 ljr (http://applescript.bratis-lover.net)
on getParentAlias(_alias)
	try
		tell application "Finder"
			set _parent to POSIX file ((POSIX path of _alias) & "/..") as alias
			return _parent
		end tell
	on error eMsg number eNum
		error "Can't getParent: " & eMsg number eNum
	end try
end getParentAlias





----- appendBasenameToParentPOSIX( basenames, parentPosix ) -----
-- Description: Appends a list of basenames to parent folder's POSIX path
-- Input: List of basenames or words
-- Parameters: The POSIX path of a parent folder, or any folder for that matter
-- Result: List of new POSIX paths using names from input
--
-- Note: If input, "basenames" were prefiltered to exclude folders, you
--       could use this function to get a list of anything not yet present
--       as a folder, format it for shell (as an array variable) using the
--       "changeListType" function, then pipe the result to a mkdir command 
--       thereby creating new folders (from names) in the parent directory
on joinBasenamesToParentPathPosix(_basenames, _parentPosix)
	if ¬
		length of (_basenames as string) is not 0 and ¬
		length of (_parentPosix as string) is not 0 then
		
		try
			set _newPaths to {}
			set _quotedForm to false
			---------------------------------------------------
			set _newDelims to ""
			set _oldDelims to AppleScript's text item delimiters
			set AppleScript's text item delimiters to _newDelims
			---------------------------------------------------
			set _parentString to _parentPosix as string
			set _item1 to _parentString's first text item
			set _itemN to _parentString's last text item
			----------------------------------------------
			if _item1 is "'" and _itemN is "'" then
				set _quotedForm to true
				set _parentString to text items 2 thru -2 of _parentString
			end if
			----------------------------------------------
			repeat with _bname in _basenames
				set _string to _bname as string
				set _itemA to _string's first text item
				set _itemZ to _string's last text item
				----------------------------------------------
				if _itemA is "'" and _itemZ is "'" then
					set _string to text items 2 thru -2 of _string
				end if
				----------------------------------------------
				set _itemPath to (_parentString & _string) as string
				----------------------------------------------
				if _quotedForm is true then
					set _itemPath to quoted form of _itemPath
				end if
				----------------------------------------------
				set end of _newPaths to _itemPath
			end repeat
			----------------------------------------------
			set AppleScript's text item delimiters to _oldDelims
			----------------------------------------------
		on error _msg number _n
			beep
			display dialog ¬
				"Oops! Something went wrong: " & {return} & {return} & ¬
				_msg & {return} & "( error code " & _n & " )" with title ("Error") with icon (caution)
			return
		end try
		
	end if
	----------------------------------------------
	return _newPaths
	----------------------------------------------
end joinBasenamesToParentPathPosix



---------------------------------------------- EOF ----------------------------------------------
