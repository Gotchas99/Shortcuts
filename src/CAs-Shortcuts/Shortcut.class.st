Class {
	#name : #Shortcut,
	#superclass : #Object,
	#instVars : [
		'filename',
		'bytes',
		'headerSize',
		'dataFlags',
		'fileAttrs'
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
Shortcut >> read [
	filename asFileReference
		binaryReadStreamDo: [ :bin | 
			self readHeaderFrom: bin.
			self readItemIdentifiersFrom: bin.
			self readLocationFrom: bin.
			self readDatafrom: bin.
			self readExtraFrom: bin ]
]

{ #category : #accessing }
Shortcut >> readDataStringFrom: bin [
	| length |
	length := (bin next: 2) unsignedShortAt: 1 bigEndian: false.
	length := length-2.
	bytes := ByteArray new: length .
	bin next: length into: bytes .
	^bytes asString.
]

{ #category : #accessing }
Shortcut >> readDatafrom: bin. [
]

{ #category : #accessing }
Shortcut >> readExtraFrom: bin [ 
]

{ #category : #accessing }
Shortcut >> readHeaderFrom: bin [
	headerSize := (bin next: 4) unsignedLongAt: 1 bigEndian: false.
	bytes := ByteArray new: headerSize.
	bin next: headerSize - 4 into: bytes startingAt: 4."to get offset right from doc"
	dataFlags := DataFlags new bytes: (bytes unsignedLongAt: 20 bigEndian: false).
	fileAttrs := FileAttributes new bytes: (bytes unsignedLongAt: 24 bigEndian: false)
]

{ #category : #accessing }
Shortcut >> readItemIdentifiersFrom: bin [
	(dataFlags hasItemIdentifier)ifTrue: [  ]
]

{ #category : #accessing }
Shortcut >> readLocationFrom: bin. [
]
