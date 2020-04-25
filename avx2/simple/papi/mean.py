import sys
vers={ }
print(sys.stdin.readline().rstrip())
for line in sys.stdin:
    vetor=line.rstrip().split(',')
    if vetor[0] not in vers:
        vers[vetor[0]] = { }
    if vetor[1] not in vers[vetor[0]]:
        vers[vetor[0]][vetor[1]] = { }
    if vetor[2] not in vers[vetor[0][vetor[1]]:
        vers[vetor[0]][vetor[1]][vetor[2]] = { }
    if vetor[3] not in vers[vetor[0]][vetor[1]][vetor[2]]:
        vers[vetor[0]][vetor[1]][vetor[2]][vetor[3]] = []
    vers[vetor[0]][vetor[1]][vetor[2]][vetor[3]].append(int(vetor[5]))
    print(vers)

for counter in vers:
	for version in vers[counter]:
		print (counter+','+version+','+str(sum(vers[counter][version])/len(vers[counter][version])))
