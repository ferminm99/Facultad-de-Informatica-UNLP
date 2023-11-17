Object subclass: #CuOOra
	aUser addQuestion: aQuestion.
	questions add: aQuestion.! !
	users add: aUser 
! !
	topics add: aTopic 
! !
	questions add: aQuestion! !
	^ users! !
	^ questions! !
	^ topics! !
	users := OrderedCollection new.
	topics := OrderedCollection new.
	questions := OrderedCollection new! !
	^title ! !
	^topics ! !
	title := aTitle ! !
	topics add: aTopic.
	aTopic addQuestion: self.
! !
	answers add: anAnswer.
! !
	^ description! !
	^ questions! !
	^name! !
	name := anObject! !
	questions add: aQuetion ! !
	description := anObject! !
	^ publication! !
	^ isLike! !
	^ user! !
	user := anObject! !
	isLike := true.! !
	isLike := false.! !
	publication := anObject! !
	isLike := isLike not.! !
	answerWithoutVotes := Answer new:'An answer'  user:(User new).! !