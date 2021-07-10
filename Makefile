
rebuild:
	docker build --no-cache=true -t armleocpu_toolset:current . 
main:
	docker build -t armleocpu_toolset:current .