Class {
	#name : #Shortcut,
	#superclass : #Object,
	#instVars : [
		'filename',
		'bytes'
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
	 bytes := filename asFileReference
		binaryReadStreamDo: [ :bin | 
			self readHeaderFrom: bin.
			self readIdentifiersFrom: bin.
			self readLocationFrom: bin.
			self readDatafrom: bin.
			self readExtraFrom: bin ]
]

{ #category : #accessing }
Shortcut >> readDatafrom: bin. [
]

{ #category : #accessing }
Shortcut >> readExtraFrom: bin [ 
]

{ #category : #accessing }
Shortcut >> readHeaderFrom: bin [
]

{ #category : #accessing }
Shortcut >> readIdentifiersFrom: bin. [
]

{ #category : #accessing }
Shortcut >> readLocationFrom: bin. [
]
