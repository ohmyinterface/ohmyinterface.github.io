
# создаем переменные для гироскопа
accX = 0
accY = 0
accZ = 0
swipeInt = 1
# создаем переменные для отследивания нажатия пальца
cursorX = 0
cursorY = 0
clickProductLayer = new Layer
	scale:0

#обнуляем параметры
addBtn.scale=0
addCard.opacity=0
myProd.opacity=0
#состояния для карты
cardInfo=[["**** 3945","25 329,00 ₽ ","Visa Platinum"],
			["**** 4054","4 392,90 ₽ ","Visa Gold"]]

#создаем массив карт
productMassive=[cardFrameOneOpen,cardFrameTwoOpen]

# считаем высоту устройства (потом понадобиться)
deviceWidth = Framer.Device.screen.width / 3
deviceHeight = Framer.Device.screen.height / 3

# история
scrollHistory = new ScrollComponent
	width: Screen.width
	height: Screen.height
	scrollHorizontal: false

scrollHistory.content.addChild(historyScreen)
scrollHistory.addChild(stickyHeader)
stickyHeader.width=historyScreen.width=deviceWidth
stickyHeader.x=stickyHeader.y=0
historyScreen.x=historyScreen.y=0

# анимация хедера
changeHeaderIndicator = 0
scrollHistory.onMove ->
	if(scrollHistory.content.y<-100 && changeHeaderIndicator==0)
		
		historyHeader.animate
			y: 56
			fontSize:18
			options:
				time: 0.3
				curve: Bezier.ease
				
		homeText.animate
			y: 12
			fontSize:13	
			options:
				time: 0.3
				curve: Bezier.ease
				
		searchFrame.animate
			opacity: 0
			y:searchFrame.y-50
			options:
				time: 0.3
				curve: Bezier.ease
				
		stickyHeader.animate
			height:100
			shadowSpread: 1
			shadowColor: "rgba(120,119,120,0.06)"
			shadowY: 3
			shadowBlur: 10
			options:
				time: 0.3
				curve: Bezier.ease
		homeLine.animate
			opacity: 0
			y:homeLine-50	
			options:
				time: 0.3
				curve: Bezier.ease
		searchStick.animate
			opacity: 1
			options:
				time: 0.3
				curve: Bezier.ease
			
			
		
				
		changeHeaderIndicator=1
		
	else if (scrollHistory.content.y>-100 && changeHeaderIndicator==1)
	
		historyHeader.animate
			y: 89
			fontSize:32
			options:
				time: 0.3
				curve: Bezier.ease
				
		searchFrame.animate
			opacity: 1
			y:searchFrame.y+50
			options:
				time: 0.3
				curve: Bezier.ease
		
		homeText.animate
			y: 143
			fontSize:15	
			options:
				time: 0.3
				curve: Bezier.ease
		
		stickyHeader.animate
			height:253
			shadowSpread: 1
			shadowColor: "rgba(120,119,120,0.06)"
			shadowY: 3
			shadowBlur: 10
			options:
				time: 0.3
				curve: Bezier.ease
				
		homeLine.animate
			opacity: 1
			y:homeLine+50	
			options:
				time: 0.3
				curve: Bezier.ease
				
		searchStick.animate
			opacity: 0
			options:
				time: 0.3
				curve: Bezier.ease
			
				
				
		changeHeaderIndicator=0



# Create a PageComponent 
verticalPage = new PageComponent
	scrollHorizontal: false
	width:deviceWidth
	height:deviceHeight

requestScreen.width=payScreen.width=loadScreen.width=deviceWidth

verticalPage.addPage(requestScreen)
verticalPage.addPage(mainFrame,"bottom")
verticalPage.addPage(payScreen,"bottom")
verticalPage.snapToPage(mainFrame,0)

mainFrame.addChild(loadScreen)
mainFrame.addChild(overlay)
overlay.opacity=0;
loadScreen.x=overlay.x=0
loadScreen.y=overlay.y=0

#анимируем прелоадер
loadScreen.animate
	opacity:0
	options:
		time: 0.4
		curve: Bezier.ease
		delay: 1.20
		
animationA = new Animation overlay,
	opacity:1
	options: 
		time: 0.6
		curve: Bezier.ease
		delay: 2.20
			
animationA.start(1000)

animationA.on Events.AnimationEnd, ->
	overlay.animate
		opacity:0
		options:
			time: 0.6
			curve: Bezier.ease
			delay: 1.2
	
logo.animate
	scale:2
	opacity: 0
	options:
		time: 0.4
		curve: Bezier.ease
		delay: 0.60


pageFlow=new FlowComponent
pageFlow.showNext(scrollHistory)
pageFlow.showNext(verticalPage)

historyContent.onSwipeLeft ->
	pageFlow.showNext(verticalPage)

mainFrame.onSwipeLeft ->
	pageFlow.showNext(photoScreen)
	
mainFrame.onSwipeRightStart ->
	pageFlow.showPrevious()

photoScreen.onSwipeRightStart ->
	pageFlow.showPrevious()



#создаем свайп предложения в истории

# этот слой чисто вспомогательный для корректного свайпа
helpLayer=new Layer
	width:120
	height: offerCard1.height
	opacity:0
	
offerPage= new PageComponent
	scrollVertical: false
	x:0
	y:offerCard1.y
	width:deviceWidth
	height: offerCard1.height
	parent: historyScreen
	originX : 0.2
	
offerCardMassive=[offerCard1,offerCard2,offerCard3]

offerPage.addPage(offerCard1)
offerPage.addPage(offerCard2)
offerPage.addPage(offerCard3)
offerPage.addPage(helpLayer)

for i in [0..2]
	offerCardMassive[i].x=20+i*offerCardMassive[i].width+10*i

# изменения градиента при гироскопе
window.addEventListener "deviceorientation", (event) ->
	accX = event.beta - 35 # 35 градусов - угол при котором мы держим устройства
	accY = event.gamma
	gradientOpacity= (100*Math.abs(accX)+Math.abs(accY*4))/2500
	if(accX>0)
		angle = accY*1.5
		swipeUpFrame.animate
			opacity:gradientOpacity*swipeInt
			options:
				time: 0.1
				curve: Bezier.ease
		swipeDownFrame.animate
			opacity:0
			options:
				time: 0.1
				curve: Bezier.ease
	else
		swipeUpFrame.animate
			opacity:0
			options:
				time: 0.1
				curve: Bezier.ease
		swipeDownFrame.animate
			opacity:gradientOpacity*swipeInt
			options:
				time: 0.1
				curve: Bezier.ease
			
		angle = 180 - accY*1.5
#считаем прозрачность как отклонение от нормального положения


# анимируем градиент с углом с прозрачностью
	mainScreen.animate
		options:
			time: 0.1
			curve: Bezier.ease
		gradient:    
			start: "rgba(215, 0, 0,"+gradientOpacity+")"
			end:"rgba(10, 40, 148, 1)"
			angle: angle

	
# считаем положение пальца при нажатии на главный экран


mainFrame.onTouchStart (event, layer) ->	
	cursorX = event.x
	cursorY = event.y


# анимация при клике на продукт
cardFrameOne.onClick (event, layer) ->
	swipeInt=0
	#удаляем слой эфекта клика
	clickProductLayer.destroy()
	
	cardFrameOne.ignoreEvents = true
	cardFrameOneOpen.ignoreEvents=cardFrameTwoOpen.ignoreEvents=false
	icn1.animate
		opacity: 0
		options:
			time: 0.4
			curve: Bezier.easeInOut
			
	icn2.animate
		opacity: 0
		options:
			time: 0.4
			curve: Bezier.easeInOut
			
	addBtn.animate
		scale: 1
		options:
			time: 0.4
			curve: Bezier.easeInOut
			
	addCard.animate
		opacity: 0.7
		options:
			time: 0.4
			curve: Bezier.easeInOut
	myProd.animate
		opacity: 0.7
		options:
			time: 0.4
			curve: Bezier.easeInOut
			
	cardFrameOne.animate
		opacity: 0
		y: cardFrameOne.y+40
		options:
			time: 0.4
			curve: Bezier.easeInOut			
	cardFrameOneOpen.animate
		opacity: 1
		scale: 1
		y:cardFrameOneOpen.y+40
		options:
			time: 0.4
			curve: Bezier.easeInOut
			delay: 0.45
			
	cardFrameTwoOpen.animate
		opacity: 1
		scale: 1
		y:cardFrameTwoOpen.y+40
		options:
			time: 0.4
			curve: Bezier.easeInOut
			delay: 0.35

#функция анимации при выборе карты
cardOpenAnimation = ->
	swipeInt=1
	cardFrameOne.ignoreEvents = false
	cardFrameOneOpen.ignoreEvents=cardFrameTwoOpen.ignoreEvents=true
	
	#подставляем значения в продукт
	for i in [0..cardInfo.length-1]
	
		if this.name==productMassive[i].name
			this.clip = true
			clickProductLayer = new Layer
				parent: this
				width: 50
				height: 50
				borderRadius: 300
				backgroundColor: "#fff"
				x: 0
				y: 0
				opacity:0.5
			
			clickProductLayer.animate
				width: 500
				height: 500
				x:clickProductLayer.x-220
				y:clickProductLayer.y-220
				opacity : 0
				options:
					time: 0.5
					curve: Bezier.easeInOut
			
			cardNumber.text=cardInfo[i][0]
			Summ.text=cardInfo[i][1]
			cardType.text=cardInfo[i][2]

	icn1.animate
		opacity: 1
		options:
			time: 0.4
			curve: Bezier.easeInOut
			
	icn2.animate
		opacity: 1
		options:
			time: 0.4
			curve: Bezier.easeInOut
			
	addBtn.animate
		scale: 0
		options:
			time: 0.4
			curve: Bezier.easeInOut
			
	addCard.animate
		opacity: 0
		options:
			time: 0.4
			curve: Bezier.easeInOut
	myProd.animate
		opacity: 0
		options:
			time: 0.4
			curve: Bezier.easeInOut
			
	cardFrameOne.animate
		opacity: 1
		y: cardFrameOne.y-40
		options:
			time: 0.4
			curve: Bezier.easeInOut
			delay: 0.55
			
	cardFrameOneOpen.animate
		opacity: 0
		scale: 0.85
		y:cardFrameOneOpen.y-40
		options:
			time: 0.4
			curve: Bezier.easeInOut
			delay: 0.10
			
	cardFrameTwoOpen.animate
		opacity: 0
		scale: 0.85
		y:cardFrameTwoOpen.y-40
		options:
			time: 0.4
			curve: Bezier.easeInOut
			delay: 0.20

	# анимация при выборе продукта
for i in [0..cardInfo.length-1]
	productMassive[i].onClick(cardOpenAnimation)

#это чтоб убрать действия в начальном состоянии
cardFrameOneOpen.scale = cardFrameTwoOpen.scale = 0.85
cardFrameOneOpen.ignoreEvents=cardFrameTwoOpen.ignoreEvents=true

icn1.onClick (event, layer) ->
	pageFlow.showPrevious()

homeText.onClick (event, layer) ->
	pageFlow.showNext(verticalPage)

icn2.onClick (event, layer) ->
	pageFlow.showNext(photoScreen)
	

#Создание видео	
	
videoLayer = new VideoLayer size: Screen.size, backgroundColor: "black"
videoLayer.parent = photoScreen
videoLayer.player.style.objectFit = "fill"

photoButton = new Layer
	parent:videoLayer
	width: 50
	height: 50
	backgroundColor: "fff" 
	borderRadius: 25
	x:deviceWidth/2-25
	y:deviceHeight-100

photoButtonStroke = new Layer
	parent:photoButton
	width: 60
	height: 60
	borderRadius: 30
	backgroundColor: "rgba(0,0,0,0)"
	borderWidth: 2
	borderColor: "fff"
	x:-5
	y:-5


videoLayer.addChild(photoDone)
photoDone.x=0
photoDone.y=deviceHeight-photoDone.height
photoDone.opacity = 0

photoButton.onClick (event, layer) ->
	videoLayer.player.pause()
	photoButton.opacity=0
	photoButtonStroke.opacity=0
	photoDone.opacity = 1

refreshIcon.onClick (event, layer) ->
	videoLayer.player.play()
	photoButton.opacity=1
	photoButtonStroke.opacity=1	
	photoDone.opacity = 0
			

constraints = window.constraints =
	audio: false
	video: { facingMode: { exact: "environment" } }


handleSuccess = (stream) ->

	videoTracks = stream.getVideoTracks()
#	print 'Got stream with constraints:', constraints
#	print 'Using video device: ' + videoTracks[0].label


	window.stream = stream
	# make variable available to browser console
	videoLayer.player.srcObject = stream
	videoLayer.player.play()
	return

handleError = (error) ->
	if error.name == 'ConstraintNotSatisfiedError'
		errorMsg 'The resolution ' + constraints.video.width.exact + 'x' + constraints.video.width.exact + ' px is not supported by your device.'
	else if error.name == 'PermissionDeniedError'
		errorMsg 'Permissions have not been granted to use your camera and ' + 'microphone, you need to allow the page access to your devices in ' + 'order for the demo to work.'
	errorMsg 'getUserMedia error: ' + error.name, error
	return

errorMsg = (msg, error) ->
	print msg
	if typeof error != 'undefined'
		console.error error
	return

# print navigator.userAgent
# print navigator.mediaDevices
if Utils.isMobile()
	navigator.mediaDevices.getUserMedia(constraints).then(handleSuccess).catch handleError



  