"
I am simple logical grouping in the hierarchy that supports multi-results in response to multi-statement queries. The server indicates the presence of more result(set) using the server status flag of specific packets. This may mean that some of my subclasses may point to the next response in the chain if multi-results were sent by the server. Check selector #next and #next: for more.
"
Class {
	#name : #MysqlResult,
	#superclass : #MysqlPacket,
	#instVars : [
		'nextResult'
	],
	#category : #'MySQL-Packet'
}

{ #category : #'as yet unclassified' }
MysqlResult >> hasMoreResults [
	^ false 
]

{ #category : #'as yet unclassified' }
MysqlResult >> nextResult [
	^ nextResult 
]

{ #category : #'as yet unclassified' }
MysqlResult >> nextResult: aResult [
	nextResult := aResult 
	
]
