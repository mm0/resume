# LaTeX Resume
[![Generate and Publish Resume](https://github.com/mm0/resume/actions/workflows/action.yml/badge.svg)](https://github.com/mm0/resume/actions/workflows/action.yml)

Use Github Workflows to generate your resume/latex file and publish it to the repository as a Release asset.

## Github Repository Configuration
Secrets:
- dockerhub_username (to pull miktex image)
- dockerhub_password
- GITHUB_TOKEN (to create github release and publish to it)

See: 

https://github.com/mm0/resume/blob/35eca877ef73cdb480f1d99ef81b36833fa45a2c/.github/workflows/action.yml#L1-L56


## To build locally:

### First install miktex, etc

```bash
miktex-lualatex --output-directory=./ resume.tex
```

### Using docker

+ Pull miktex image
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
    -v `pwd`:/miktex/work miktex/miktex-lualatex  bash -c "mpm --admin --update-db && initexmf --admin --update-fndb && miktex-lualatex resume.tex"
  ```


### [Direct link to Resume](https://github.com/mm0/resume/releases/download/my-resume/MattMargolinResume.pdf)

### References
- Minipage (https://latex-tutorial.com/minipage-latex/)
- Lists (https://latex-tutorial.com/tutorials/lists/)
- Inspired by: https://github.com/GiantMolecularCloud/my-resume/

