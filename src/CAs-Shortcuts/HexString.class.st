Class {
	#name : #HexString,
	#superclass : #Object,
	#instVars : [
		'number'
	],
	#category : #'CAs-Shortcuts'
}

{ #category : #'instance creation' }
HexString class >> on: aHexString [
^self new on: aHexString	
]

{ #category : #'instance creation' }
HexString >> hexString [
^'0x', (number printStringBase:16)
]

{ #category : #'instance creation' }
HexString >> number [
^number
]

{ #category : #'instance creation' }
HexString >> on: aHexString [
| tmp |
tmp:= aHexString allButFirst:2.
	number := Integer readFrom: tmp base: 16
]
