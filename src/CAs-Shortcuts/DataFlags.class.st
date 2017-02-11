Class {
	#name : #DataFlags,
	#superclass : #Object,
	#instVars : [
		'flagsInt'
	],
	#classVars : [
		'FlagTable'
	],
	#category : #'CAs-Shortcuts'
}

{ #category : #initialization }
DataFlags class >> compileFlagTable [
	| fd id tag |
	fd := Dictionary new.
	id := ''.
	tag := ''.
	self tbl lines
		reject: [ :l | l isEmpty ]
		thenDo: [ :l | 
			(l beginsWith: '0x')
				ifTrue: [ fd at: tag put: id.
					id := l.
					tag := '' ]
				ifFalse: [ tag isEmpty
						ifTrue: [ tag := l asSymbol ] ] ].
	FlagTable := fd
]

{ #category : #initialization }
DataFlags class >> flagTable [
	^
	FlagTable 
]

{ #category : #initialization }
DataFlags class >> initialize [
	self compileFlagTable
]

{ #category : #initialization }
DataFlags class >> tbl [
	^'0x00000001

HasTargetIDList

The LNK file contains a link target identifier

0x00000002

HasLinkInfo

The LNK file contains location information

0x00000004

HasName

The LNK file contains a description data string

0x00000008

HasRelativePath

The LNK file contains a relative path data string

0x00000010

HasWorkingDir

The LNK file contains a working directory data string

0x00000020

HasArguments

The LNK file contains a command line arguments data string

0x00000040

HasIconLocation

The LNK file contains a custom icon location

0x00000080

IsUnicode

The data strings in the LNK file are stored in Unicode (UTF-16 little-endian) instead of ASCII

0x00000100

ForceNoLinkInfo

The location information is ignored

0x00000200

HasExpString

The LNK file contains environment variables location data block

0x00000400

RunInSeparateProcess

A 16-bit target application is run in a separate virtual machine.

0x00000800

Unknown (Reserved)

0x00001000

HasDarwinID

The LNK file contains a Darwin (Mac OS-X) properties data block

0x00002000

RunAsUser

The target application is run as a different user.

0x00004000

HasExpIcon

The LNK file contains an icon location data block

0x00008000

NoPidlAlias

The file system location is represented in the shell namespace when the path to an item is parsed into the link target identifiers
Contains a known folder location data block?

0x00010000

Unknown (Reserved)

Windows Vista and later?

0x00020000

RunWithShimLayer

The target application is run with the shim layer. The LNK file contains shim layer properties data block.

0x00040000

ForceNoLinkTrack

The LNK does not contain a distributed link tracking data block

0x00080000

EnableTargetMetadata

The LNK file contains a metadata property store data block

0x00100000

DisableLinkPathTracking

The environment variables location block should be ignored

0x00200000

DisableKnownFolderTracking

Unknown

0x00400000

DisableKnownFolderAlias

Unknown

0x00800000

AllowLinkToLink

Unknown

0x01000000

UnaliasOnSave

Unknown

0x02000000

PreferEnvironmentPath

Unknown

0x04000000

KeepLocalIDListForUNCTarget

Unknown'
]

{ #category : #accessing }
DataFlags >> bytes: aLongInteger [
flagsInt:= aLongInteger 
]

{ #category : #accessing }
DataFlags >> has: aTag [
	| mask maskHex |
	maskHex := self class flagTable at: aTag.
	mask := (HexString on: maskHex) number.
	^ flagsInt allMask: mask
]
