---- FinderLib Quick Start File -----

-- load library
set _finderLib to load script alias ((path to home folder as text) & "Library:Script Libraries:" & "AppleScript_finderLib.scpt")

-- put the library to work
tell _finderLib
	
	set _items to getSelection()
	--->  {item, item, item, ...}
	
	set _files to getOnlyFiles(_items)
	--->  {file, file, file, ...}
	
	set _folders to getOnlyFolders(_items)
	--->  {folder, folder, folder, ...}
	
	set _item to getFirstItem(_items)
	--->  item
	
	set _names to getNames(_items)
	--->  {fullname, fullname, fullname, ...}
	
	set _basenames to getBasenames(_items)
	--->  {basename, basename, basename, ...}
	
	set _firstItemBasename to getBasenameOfFirstItem(_items)
	--->  basename
	
	set _basenamesFiles to getBasenamesOfOnlyFiles(_items)
	--->  {basename, basename, basename, ...}
	
	set _extensions to getExtensions(_items)
	--->  {extension, extension, [null], ...}
	
	set _extensionsFiles to getExtensionsOfOnlyFiles(_items)
	--->  {extension, extension, extension, ...}
	
	set _extensionsToggled to toggleExtensionsHidden(_items)
	--->  (shows/hides extensions)
	
	set _paths to getPosixPaths(_items)
	--->  {POSIX path, POSIX path, POSIX path, ...}
	
	set _pathsQ to getPosixPathsQ(_items)
	--->  {'POSIX path', 'POSIX path', 'POSIX path', ...}
	
	set _pathsShell to getEscapedPosixArray(_items)
	--->  "(EscapedPOSIXpath EscapedPOSIXpath EscapedPOSIXpath ...)"
	
	set _pathsHFS to getHFSPaths(_items)
	--->  {HFS path, HFS path, HFS path, ...}
	
	set _pathsHFSQ to getHFSPathsQ(_items)
	--->  {'HFS path', 'HFS path', 'HFS path', ...}
	
	set _pathsParent to getParentPosix(_items)
	--->  {parent POSIX path, parent POSIX path, parent POSIX path, ...}
	
	set _pathsParentHFS to getParentHFS(_items)
	--->  {parent HFS path, parent HFS path, parent HFS path, ...} 
	
	set _basename to getBasenameOfItem(_item)
	--->  basename
	
	set _name_ext to getNameAndExt(_item)
	--->  {name, extension}
	
	set _comment to getCommentOfItem(_item)
	--->  comment
	
	set _parent to getContainerOfItem(_item)
	--->  parent folder
	
	set _properties to getPropertiesOfItem(_item)
	--->  {property:value, property:value, property:value, ...}
	
	set _parentAlias to getParentAlias(_alias)
	--->  parent alias
	
	set _conjuredPaths to appendBasenamesToParentPOSIX(_basenames, _pathParent)
	--->  {full POSIX path, full POSIX path, full POSIX path, ...}
	
end tell
