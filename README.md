# Open Source Development Kit for GemStone/S 64 Bit [![master branch:](https://travis-ci.org/GsDevKit/gsDevKitHome.png?branch=master)](https://travis-ci.org/GsDevKit/gsDevKitHome)

The Development Kit for GemStone/S features:

* [Simplified GemStone/S installation](#development-kit-server-installation).
* [Remote Client installation](#remote-dev-kit-client-installation).
* [Scripts for controlling multiple stones](#gemstone-s-management-scripts).
* [New development environment](#tode--the-object-centric-development-environment).
* [Library of projects ported to GemStone/S](#development-kit-projects).

##Development Kit Server Installation

1. [Fork][3] the [gsDevKitHome project][2] on [GitHub][15].
2. Clone your fork of the [gsDevKitHome project][2] to your GemStone development server and create a unique branch for your project-specific changes.
   Changes that you want to share with the community should be made on the master branch:

   ```Shell
   git clone git@github.com:<your github id>/gsDevKitHome.git
   cd gsDevKitHome
   git checkout -b  <your branch name>
   ```

3. Define the `$GS_HOME` environment variable and add `$GS_HOME/bin` to your `$PATH`:

   ```Shell
   cd gsDevKitHome
   export GS_HOME=`pwd`
   export PATH=$GS_HOME/bin:$PATH
   ```

   It's a good idea to define `$GS_HOME` and `$PATH` in your `.bashrc` file.
4. Install GemStone/S and Pharo, build the tODE client image, create a stone, start the stone, start the netldi, start the stamonitors, install tODE in stone and launch the tODE client. 
   The following creates a new stone named `tode` based on [version 3.2.1 of GemStone/S][16]:

   ```Shell
   installServer tode 3.2.1
   ```

   *Note that the script will prompt you for your password because it uses sudo to setup up your server for running GemStone*.
  

4.  When the above script finishes, the tode client image is opened and you should be able to validate your session description by:

   1. Opening a tODE shell on your stone: 
   
      ![open tode shell][18]

   2. Opening a `project list`:

      ![project list][19]

   3. If the `project list` opens successfully, then you are done.
      If an error occurs, use the testLogin command to gather diagnostic information:

      ![testLogin output][20]

      If you need help, copy the result of the `testLogin` command and send mail to the [GLASS mailing list][].

5. Once you have verified that the session description is correct, commit the changes that you've made and push them to GitHub:

   ```Shell
   git status                          # see what changes have been made
   git add --all                       # stage the changed files
   git commit -m"initial installation" # commit changes
   git push origin <your branch name>  # push the changes to GitHub
   ```

## Remote Dev Kit Client Installation

If you have a separate client machine separate from your development server, then follow the [tODE client installation instructions][17].

##tODE: the Object-centric Development Environment
##GemStone/S Management Scripts

* [stones](#stones)
* [createTodeStone](#createtodestone)
* [stopStone](#stopstone)
* [startStone](#startstone)
* [startNetldi](startnetldi)

###stones
The [stones][27] script produces a report listing *Installed Products*, *Installed Stones*, *Running Stones*, and *Running Netldis*: 

```Shell
stones
```

Here's a sample report:

```
Installed Products:
	2.4.5.2
	3.0.1
	3.1.0.5
	3.1.0.6
	3.2.0
	3.2.1
Installed Stones:
	2.4.5.2	c_2452
	3.0.1	c_301
	3.1.0.5	c_3105
	3.2.1	gemtalk
	3.2.2	j_
	3.3.0	k_
	3.2.0	m_
Running Stones:
	Status       Version    Owner    Pid   Port   Started     Type       Name
	-------     --------- --------- ----- ----- ------------ ------      ----
	exists  3.2.0     dhenrich   2074 52832 Jul 22 10:36 Stone       m_
	exists  3.1.0.5   dhenrich   2450 46781 Jul 22 10:39 Stone       c_3105
	exists  2.4.5.2   dhenrich   2291 45711 Jul 22 10:37 Stone       c_2452
	exists  3.2.2     dhenrich   1980 43002 Jul 22 10:35 Stone       j_
	exists  3.0.1     dhenrich   2365 45327 Jul 22 10:38 Stone       c_301
	exists  3.2.1     dhenrich  18934 47480 Jul 24 10:25 Stone       gemtalk
Running Netldis:
	Status       Version    Owner    Pid   Port   Started     Type       Name
	-------     --------- --------- ----- ----- ------------ ------      ----
	exists  3.2.1     dhenrich  20901 49481 Jul 24 16:17 Netldi      gemtalk_ldi
	exists  3.2.0     dhenrich   2196 37538 Jul 22 10:36 Netldi      m_ldi
	exists  3.1.0.5   dhenrich   2514 38890 Jul 22 10:39 Netldi      c_ldi_3105
	exists  3.2.2     dhenrich   2048 44409 Jul 22 10:35 Netldi      j_ldi
	exists  3.0.1     dhenrich   2426 54616 Jul 22 10:38 Netldi      c_ldi_301
	exists  2.4.5.2   dhenrich   2340 54731 Jul 22 10:37 Netldi      c_ldi_2452
	exists  3.3.0     dhenrich   2274 33236 Jul 22 10:36 Netldi      k_ldi
```

###createTodeStone
The [createTodeStone][28] script creates a new stone of the given name and GemStone/S version:

```Shell
createTodeStone devKit 3.1.0.6
```

The stone is created in the `$GS_HOME/gemstone/stones` directory. 
After the stone is created, the stone and netldi processes are started and then tODE is installed.

*Note that the GemStone/S version must be previously installed using the [installGemStone][29] script*.

###stopStone
The [stopStone][30] script is used to stop a running stone by name:

```Shell
stopStone devKit
```

Use the [stones][27] script to get a list of the running stones.

###startStone
The [startStone][31] script is used to start a stone by name:

```Shell
startStone devKit
```

###startNetldi
The [startNetldi][32] script is used to start a netldi for the given stone:

```Shell
startNetldi devKit
```

By default, the name of the netldi is constructed by tacking `_ldi` onto the name of the stone. 
If you want to use a different netldi name, edit the $GS_HOME/gemstone/stones/\<stone-name\>/info.ston file:

```
GsDevKitStoneInfo {
	#stoneName : 'tode',
	#gsVers : '3.2.1',
	#username : nil,
	#netldiName : nil
}
```

##Development Kit Projects

Here is a sampling of some of the open source projects that have been ported to GemStone/S:

| Project | Description|
|---------|------------|
| Magritte| [Dynamic Meta-Description Framework][21]   |
| Pier|[Content Management System][22] |
|[Seaside31][23]| [Dynamic Web Development Framework][24] |
|[ZincHTTPComponents][25]| [Web Server/Client][26] |

For information about installing optional projects and a complete list of optional projects, visit the [GsDevKit Projects][27] page.

[1]: https://help.github.com/articles/fork-a-repo
[2]: https://github.com/GsDevKit/gsDevKitHome
[3]: https://github.com/GsDevKit/gsDevKitHome/fork
[4]: https://help.github.com/articles/fork-a-repo#step-2-clone-your-fork
[5]: bin/README.md
[6]: http://gemtalksystems.com/index.php/products/gemstones/
[7]: http://pharo.org/
[8]: https://github.com/dalehenrich/tode#tode-the-object-centric-development-environment-
[9]: gemstone/README.md
[10]: gemstone/downloads
[11]: gemstone/products
[12]: gemstone/stones
[13]: tode
[14]: pharo
[15]: https://github.com
[16]: http://gemtalksystems.com/index.php/news/version3-2/
[17]: docs/clientInstallation.md#tode-client-installation
[18]: docs/images/openTodeShell.png
[19]: docs/images/projectList.png
[20]: docs/images/testLoginOutput.png
[21]: https://code.google.com/p/magritte-metamodel/
[22]: http://www.piercms.com/
[23]: projects/seaside31
[24]: http://www.seaside.st/
[25]: projects/zinc
[26]: https://github.com/svenvc/zinc/blob/master/zinc-http-components-paper.md#http
[27]: projects/README.md#gsdevkit-projects
[27]: http://lists.gemtalksystems.com/mailman/listinfo/glass
[28]: bin/stones
[29]: bin/createTodeStone
[29]: bin/installGemStone
[30]: bin/stopStone
[31]: bin/startStone
[32]: bin/startNetldi
