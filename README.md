# LaTeX Resume

## To build 
### First install miktex, etc

bash```

miktex-lualatex --output-directory=./ resume.tex
```

### Using docker

- Pull miktex image
```
docker pull miktex/miktex
```

- (Optional) Create a docker volume to store dependencies in
```
docker volume create --name miktex
```

- Run docker. This will mount the miktex volume (remove second line if docker volume create was skipped).  This also mounts the current directory into /miktex/work.  It will then run the `miktex-lualatex resume.tex ` command on the miktex/miktex container.
```
docker run -ti \
  -v miktex:/miktex/.miktex \
  -v `pwd`:/miktex/work miktex/miktex-lualatex resume.tex
```



#### References
- Minipage (https://latex-tutorial.com/minipage-latex/)
- Lists (https://latex-tutorial.com/tutorials/lists/)
- Inspired by: https://github.com/GiantMolecularCloud/my-resume/



