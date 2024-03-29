Class {
	#name : #MysqlField,
	#superclass : #MysqlPacket,
	#instVars : [
		'catalog',
		'db',
		'table',
		'orgTable',
		'name',
		'orgName',
		'charSet',
		'type',
		'flags',
		'default',
		'decimals',
		'length'
	],
	#classVars : [
		'AutoIncrFlag',
		'BinaryFlag',
		'BlobFlag',
		'EnumFlag',
		'MultiKeyFlag',
		'NotNullFlag',
		'PrimaryKeyFlag',
		'SetFlag',
		'TimestampFlag',
		'UniqueKeyFlag',
		'UnsignedFlag',
		'ZeroFillFlag'
	],
	#category : #'MySQL-Packet'
}

{ #category : #'as yet unclassified' }
MysqlField class >> initBitMasksForFlags [
	NotNullFlag := 16r0001.
	PrimaryKeyFlag := 16r0002.
	UniqueKeyFlag := 16r0004.
	MultiKeyFlag := 16r0008.
	BlobFlag := 16r0010.
	UnsignedFlag := 16r0020.
	ZeroFillFlag := 16r0040.
	BinaryFlag := 16r0080.
	EnumFlag := 16r0100.
	AutoIncrFlag := 16r0200.
	TimestampFlag := 16r0400.
	SetFlag := 16r0800.
	
	

]

{ #category : #'as yet unclassified' }
MysqlField class >> initialize [
	"self initialize"
	self initBitMasksForFlags.
	
]

{ #category : #'as yet unclassified' }
MysqlField >> db [
	^ db
	
]

{ #category : #'as yet unclassified' }
MysqlField >> decimals [
	^ decimals 
]

{ #category : #'as yet unclassified' }
MysqlField >> isAutoIncrement [
	^ (flags bitAnd: AutoIncrFlag) = AutoIncrFlag   
	
]

{ #category : #'as yet unclassified' }
MysqlField >> isNullable [
	^ (flags bitAnd: NotNullFlag) ~= NotNullFlag  
	
]

{ #category : #'as yet unclassified' }
MysqlField >> isPrimaryKey [
	^ (flags bitAnd: PrimaryKeyFlag) = PrimaryKeyFlag  
	
]

{ #category : #'as yet unclassified' }
MysqlField >> isUnsigned [
	^ (flags bitAnd: UnsignedFlag) = UnsignedFlag 
	
]

{ #category : #'as yet unclassified' }
MysqlField >> length [
	^ length 
	
]

{ #category : #'as yet unclassified' }
MysqlField >> name [
	^ name
	
]

{ #category : #'as yet unclassified' }
MysqlField >> parse [
	catalog := (self decodeLcsFrom: inStream) asString.
	db := (self decodeLcsFrom: inStream) asString.
	table := (self decodeLcsFrom: inStream) asString.
	orgTable := (self decodeLcsFrom: inStream) asString.
	name := (self decodeLcsFrom: inStream) asString.
	orgName := (self decodeLcsFrom: inStream) asString.
	inStream next. "filler"
	charSet := inStream next + (inStream next bitShift: 8).
	length := inStream next + (inStream next bitShift: 8) + 
		(inStream next bitShift: 16) + (inStream next bitShift: 24).
	type := inStream next.
	flags := inStream next + (inStream next bitShift: 8).
	decimals := inStream next.
	inStream next; next. "2 filler"
	"The field default only appears for table definitions, not for normal resultsets"
	inStream atEnd ifFalse: [default := self decodeLcbFrom: inStream].
	
]

{ #category : #'as yet unclassified' }
MysqlField >> table [
	^ table
	
]

{ #category : #'as yet unclassified' }
MysqlField >> type [
	^ type
	
]
