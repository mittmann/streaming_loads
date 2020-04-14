import sys
vers={ }
print(sys.stdin.readline().rstrip())
for line in sys.stdin:
	seila=line.rstrip().split(',')
	if seila[0] not in vers:
		vers[seila[0]] = { }
	if seila[1] not in vers[seila[0]]:
		vers[seila[0]][seila[1]] = []
	vers[seila[0]][seila[1]].append(int(seila[2]))

for counter in vers:
	for version in vers[counter]:
		print (counter+','+version+','+str(sum(vers[counter][version])/len(vers[counter][version])))
