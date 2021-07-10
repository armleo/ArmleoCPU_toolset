push: main
	docker image push

main:
	docker build -t armleocpu_toolset:current .
	
rebuild:
	docker build --no-cache=true -t armleocpu_toolset:current . 