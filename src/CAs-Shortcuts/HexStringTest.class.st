Class {
	#name : #HexStringTest,
	#superclass : #TestCase,
	#category : #'CAs-Shortcuts-Test'
}

{ #category : #tests }
HexStringTest >> testHex1 [
	self assert: (HexString on: '0xF') number equals: 15
]

{ #category : #tests }
HexStringTest >> testHex2 [
	self assert: (HexString on: '0xFF') number equals: 255
]

{ #category : #tests }
HexStringTest >> testHexString1 [
	self assert: (HexString on: '0xF') hexString equals: '0xF'
]
