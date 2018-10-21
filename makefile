build:
	ls -d */ | cut -f 1 -d '/' | xargs -I {} docker build {} -t cloudbuilders/{}

push:
	ls -d */ | cut -f 1 -d '/' | xargs -I {} docker push cloudbuilders/{}

clean:
	ls -d */ | cut -f 1 -d '/' | xargs -I {} docker rmi cloudbuilders/{}

info:
	ls -d */ | cut -f 1 -d '/' | xargs -I {} docker images cloudbuilders/{}
