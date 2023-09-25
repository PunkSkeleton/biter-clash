-- constant table of biter spawning areas
biterStagingAreas = {}

-- north
leftTopX = -550
leftTopY = -550
rightBottomX = -500
rightBottomY = -500
middleX = -525
middleY = -525

while rightBottomX < 600 do
	currentArea = {}
	currentArea["leftTopX"] = leftTopX
	currentArea["leftTopY"] = leftTopY
	currentArea["rightBottomX"] = rightBottomX
	currentArea["rightBottomY"] = rightBottomY
	currentArea["middleX"] = middleX
	currentArea["middleY"] = middleY
	biterStagingAreas[#biterStagingAreas + 1] = currentArea
	leftTopX = rightBottomX
	rightBottomX = rightBottomX + 50
	middleX = middleX + 50
end

-- south
leftTopX = -550
leftTopY = 500
rightBottomX = -500
rightBottomY = 550
middleX = -525
middleY = 525

while rightBottomX < 600 do
	currentArea = {}
	currentArea["leftTopX"] = leftTopX
	currentArea["leftTopY"] = leftTopY
	currentArea["rightBottomX"] = rightBottomX
	currentArea["rightBottomY"] = rightBottomY
	currentArea["middleX"] = middleX
	currentArea["middleY"] = middleY
	biterStagingAreas[#biterStagingAreas + 1] = currentArea
	leftTopX = rightBottomX
	rightBottomX = rightBottomX + 50
	middleX = middleX + 50
end

-- west
leftTopX = -550
leftTopY = -500
rightBottomX = -500
rightBottomY = -450
middleX = -525
middleY = -475

while rightBottomY < 550 do
	currentArea = {}
	currentArea["leftTopX"] = leftTopX
	currentArea["leftTopY"] = leftTopY
	currentArea["rightBottomX"] = rightBottomX
	currentArea["rightBottomY"] = rightBottomY
	currentArea["middleX"] = middleX
	currentArea["middleY"] = middleY
	biterStagingAreas[#biterStagingAreas + 1] = currentArea
	leftTopY = rightBottomY
	rightBottomY = rightBottomY + 50
	middleY = middleY + 50
end

-- east
leftTopX = 500
leftTopY = -500
rightBottomX = 550
rightBottomY = -450
middleX = 525
middleY = -475

while rightBottomY < 550 do
	currentArea = {}
	currentArea["leftTopX"] = leftTopX
	currentArea["leftTopY"] = leftTopY
	currentArea["rightBottomX"] = rightBottomX
	currentArea["rightBottomY"] = rightBottomY
	currentArea["middleX"] = middleX
	currentArea["middleY"] = middleY
	biterStagingAreas[#biterStagingAreas + 1] = currentArea
	leftTopY = rightBottomY
	rightBottomY = rightBottomY + 50
	middleY = middleY + 50
end
