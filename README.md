# Site web de la [commission restauration](http://github.com/apelsophiebarat/gssb-menu-site)

##  Installation de l'outillage

> **Remarque: Il est conseillé d'utiliser [Sublime Text](http://www.sublimetext.com/) comme éditeur de texte.**

### Installation de l'outillage sur Windows

1. Installer le gestionnaire de packge [Chocolatey](http://chocolatey.org/)

	```
	@powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;	%systemdrive%\chocolatey\bin
	```

	pour plus d'informations allez voir la page [Getting Started](https://github.com/chocolatey/chocolatey/wiki/GettingStarted).
	On vous explique comment configurer le chemin d'installation `chocolatey_bin_root`

2. Installer [git](http://git-scm.com/) avec les outils pour windows [msysgit](http://msysgit.github.io/) et [power shell git extension](https://github.com/dahlbyk/posh-git)

	```
	cinst git.install
	cinst poshgit
	cinst git-flow-dependencies
	cinst Devbox-GitFlow
	```

3. Installer [Node.js](http://nodejs.org/)

	```
	cinst nodejs.install
	```

4. Installer [heroku-toolbelt](https://toolbelt.heroku.com/)

	```
	cinst heroku-toolbelt
	```

### Installation de l'outillage sur OSX

1. Installer [homebrew](http://brew.sh/)

	```
	ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
	```

2. Installer [git](http://git-scm.com/)

	```
	brew install git
	brew install git-flow
	```

3. Installer [Node.js](http://nodejs.org/)

	```
	brew install node
	```

4. Installer [heroku-toolbelt](https://toolbelt.heroku.com/)

	```
	brew install heroku-toolbelt
	```

## Tester le serveur en locale

1. Installer les outils de base (la première fois seulement)

	1. Executer les commandes d'installation :

		```
		npm i -g docpad
		npm i -g bower
		npm i -g mocha
		npm i -g nesh
		npm i -g coffee-script

		```

	2. Vérifier la liste des packages installés:

		```
		npm list -g --depth=0

		├── bower@1.0.0
		├── brunch@1.7.0
		├── coffee-script@1.6.3
		├── coffeelint@0.5.4
		├── docpad@*
		├── docpad-plugin-handlebarshelpers@*
		├── docpad-plugin-multiplelayouts@*
		├── docpad-plugin-rss@2.1.3
		├── docpad-plugin-schoolmenu@*
		├── grunt-cli@0.1.6
		├── ibrik@1.0.1
		├── istanbul@0.2.4
		├── mocha@1.17.1
		├── nesh@1.4.1
		├── node-inspector@0.7.0-1
		├── npm@1.3.24
		├── semver@2.2.1
		├── testacular@0.6.0
		├── xml@*
		└── yo@1.0.0-beta.3
		```

2. Cloner le dépôt [Github](https://github.com/apelsophiebarat/gssb-menu-site)

	```
	git clone https://github.com/apelsophiebarat/gssb-menu-site
	cd gssb-menu-site
	npm install
	```

3. Lancer le servuer en locale

	```
	docpad run
	```

## _[WIP]_ git flow ?

- [] [HubFlow](http://dev.datasift.com/blog/hubflow-github-and-gitflow-model-together) est un git flow utilisant les PR de github ?
- [] TODO: définir le flow d'une release,feature, smever….


## Heroku

add git remote `git@heroku.com:gssb-menu-site.git`

```
[remote "heroku"]
  url = git@heroku.com:gssb-menu-site.git
  fetch = +refs/heads/*:refs/remotes/heroku/*
```

### custom error &maintenance pages

```
heroku config:set MAINTENANCE_PAGE_URL=http://apel.s3-website-eu-west-1.amazonaws.com/heroku/menu/maintenance.html
heroku config:set ERROR_PAGE_URL=http://apel.s3-website-eu-west-1.amazonaws.com//heroku/menu/erreur.html
```

### Maintenance mode

- activate maintenance mode:

	```
	heroku maintenance:on
	```

- desactivate maintenance mode:

	```
	heroku maintenance:off
	```

- check mode:

	```
	heroku maintenance
	```


## License
Copyright &copy; 2013+ All rights reserved.
