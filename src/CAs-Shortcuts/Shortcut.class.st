Class {
	#name : #Shortcut,
	#superclass : #Object,
	#instVars : [
		'filename',
		'dataFlags',
		'fileAttrs',
		'dataStrings',
		'localPath',
		'commonPath'
	],
	#category : #'CAs-Shortcuts'
}

{ #category : #'instance creation' }
Shortcut class >> from: aFilename [
	^self new filename: aFilename 
]

{ #category : #accessing }
Shortcut >> filename: aFilename [ 
	filename:= aFilename 
]

{ #category : #accessing }
Shortcut >> localPath [
^localPath
]

{ #category : #accessing }
Shortcut >> read [
	filename asFileReference
		binaryReadStreamDo: [ :bin | 
			self readHeaderFrom: bin.
			self readShellItemIdentifiersFrom: bin.
			self readLocationFrom: bin.
			self readDatafrom: bin.
			self readExtraFrom: bin ]
]

{ #category : #accessing }
Shortcut >> readDataStringFrom: bin [
	| length bytes |
	length := (bin next: 2) unsignedShortAt: 1 bigEndian: false.
	length := length - 2.
	bytes := ByteArray new: length.
	bin next: length into: bytes.
	(dataFlags has: #IsUnicode)ifTrue: [ ] ifFalse: [
	^ bytes asString]
]

{ #category : #accessing }
Shortcut >> readDatafrom: bin [
	| description relativePath workingDirectory commandLineArguments iconLocation |
	dataStrings := Dictionary new.
	(dataFlags has: #HasName)
		ifTrue: [ description := self readDataStringFrom: bin.
			dataStrings at: #description put: description ].
	(dataFlags has: #HasRelativePath)
		ifTrue: [ relativePath := self readDataStringFrom: bin.
			dataStrings at: #relativePath put: relativePath ].
	(dataFlags has: #HasWorkingDir)
		ifTrue: [ workingDirectory := self readDataStringFrom: bin.
			dataStrings at: #workingDirectory put: workingDirectory ].
	(dataFlags has: #HasArguments)
		ifTrue: [ commandLineArguments := self readDataStringFrom: bin.
			dataStrings at: #commandLineArguments put: commandLineArguments ].
	(dataFlags has: #HasIconLocation)
		ifTrue: [ iconLocation := self readDataStringFrom: bin.
			dataStrings at: #iconLocation put: iconLocation ]
]

{ #category : #accessing }
Shortcut >> readExtraFrom: bin [ 
]

{ #category : #accessing }
Shortcut >> readHeaderFrom: bin [
	| bytes size |
	size := (bin next: 4) unsignedLongAt: 1 bigEndian: false.
	bytes := ByteArray new: size.
	bin next: size - 4 into: bytes startingAt: 4.	"to get offset right from doc"
	dataFlags := DataFlags new bytes: (bytes unsignedLongAt: 20 bigEndian: false).
	fileAttrs := FileAttributes new bytes: (bytes unsignedLongAt: 24 bigEndian: false).

]

{ #category : #accessing }
Shortcut >> readLocationFrom: bin [
	| size bytes volumeOffset localPathOffset networkShareOffset commonPathOffset   |
	(dataFlags has: #HasLinkInfo)
		ifFalse: [ ^ self ].
	size := (bin next: 4) unsignedLongAt: 1 bigEndian: false.
	bytes := ByteArray new: size.
	bin next: size - 4 into: bytes startingAt: 4.	"to get offset right from doc"
	volumeOffset := bytes unsignedLongAt: 12 bigEndian: false.
	localPathOffset := bytes unsignedLongAt: 16 bigEndian: false.
	networkShareOffset := bytes unsignedLongAt: 20 bigEndian: false.
	commonPathOffset := bytes unsignedLongAt: 24 bigEndian: false.
	localPath := self readStringFrom: bytes at: localPathOffset.
	commonPath := self readStringFrom: bytes at: commonPathOffset
]

{ #category : #accessing }
Shortcut >> readShellItemIdentifiersFrom: bin [
	| size |
	(dataFlags has: #HasTargetIDList)
		ifFalse: [ ^ self ].
	[ size := (bin next: 2) unsignedShortAt: 1 bigEndian: false.
	size > 0 ] 

whileTrue: [ bin next: size - 2 ]
]

{ #category : #accessing }
Shortcut >> readStringFrom: buffer at: offset [
	| ptr tmp ch c |
	ptr := offset.
	tmp := ''.
	[ c := buffer at: ptr.
	c > 0 ]
		whileTrue: [ ch := Character value: c.
			tmp := tmp copyWith: ch.
			ptr := ptr + 1 ].^tmp
]
