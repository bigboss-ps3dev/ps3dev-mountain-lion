====================
 What does this do?
====================

 This program will automatically build and install a compiler and other
 tools official and homebrew used in the creation of official and homebrew 
 software for the Sony PlayStation 3 videogame system using Osx Mountain Lion

===================
 What do i need ?
===================

 You will need a few tool installed before:
 <dl>
 <dt>1) Your mac with Osx Mountain Lion. All was tested with mac mini late 2012</dt>
  
 <dt>2) Enable root account. Ref http://support.apple.com/kb/PH11331 </dt>
  
 <dt>3) Install xquartz (x11) Ref http://xquartz.macosforge.org/landing/</dt>
  
 <dt> 4) Install xcode from app store. </dt>
 After install it, open it and install command line tools.
 You must go yo Downloads section of Xcode's preferences to do it
  
 <dt>5) Install macport https://distfiles.macports.org/MacPorts/MacPorts-2.1.3-10.8-MountainLion.pkg </dt>
  
 <dt>6) Update macport and enable +universal </dt>
 
 sudo port -v selfupdate
 
 it will ask you root password, after finish it execute the following line:
 
 <p> if [ \`sysctl -n hw.cpu64bit_capable\` -eq 1 ] ; then echo "+universal" | sudo tee -a /opt/local/etc/macports/variants.conf; else echo "not 64bit capable"; fi</p>
  
 <dt>7) Install port utils (I installed these, you can have other requirements)  </dt>
sudo port install autoconf automake bison flex texinfo ncurses wget libelf zlib libtool git-core gmp openssl mpfr libmpc unrar subversion bzip2
  
<dt> 8) Install wine port i use it when some Sony tools are not availables in osx </dt>
 
  sudo port install wine
 
 after finish it open a new terminal and run 
 
  winecfg
  
 it will create basic wine configuration needed later 
 
 Run these commands from terminal
 
  sudo launchctl load -w /Library/LaunchDaemons/org.freedesktop.dbus-system.plist
  
  launchctl load -w /Library/LaunchAgents/org.freedesktop.dbus-session.plist
  
 <dt>9) Create /usr/local/cell and /usr/local/ps3dev folder: </dt>
 
   su -
   
 it will ask you root password 
 
   mkdir -p /usr/local/cell 
   
   mkdir -p /usr/local/ps3dev
  
 I am using my own user and group, use your own configuration as you like
 
  chown -R bigboss:staff /usr/local/cell
  
  chown -R bigboss:staff /usr/local/ps3dev
  
 <dt>10) Go to /usr/local/cell and get my repository </dt>
 
 mkdir /usr/local/cell/work
 
 cd /usr/local/cell/work
 
 git clone https://github.com/bigboss-ps3dev/ps3dev-mountain-lion.git
 
 <dt>11) Install a good and light editor</dt>
 
 I am using one of the best editor ever made Textmate you can get it from https://github.com/textmate/textmate there are prebuilt binaries
 
 </dl>
===================
 How do I use it to build Sony toolchain?
===================
<dl>
<dt>1) Get Sony SDK 3.60 full</dt>
 google for it or if you are a Sony PlayStation licensee get it from scedev.net as usual
<dt>2) You will need to put some files on /usr/local/cell/work/sdk this directory is not in my repo, don't upload illegal stuff to github please. </dt>

 These files are mandatory put on /usr/local/cell/work/sdk if you have other names change the script build_sony.sh or change filenames:
 
 <ul>
 <li>[159]-PS3_SDK-360_002.zip </li>
 <li>[166]-PS3_SDK_Samples-360_001.zip</li>
 <li>[78]-PS3_SDK-360_001.zip</li>
 <li>toolchain-src-3.6.0-GCC411.zip</li>
 </ul>

 These files are optional put on /usr/local/cell/work/sdk
 
 <ul>
 <li>[28]-PS3_SDKDoc-360_01-CHM-English.zip</li>
 <li>[29]-PS3_SDKDoc-360_01-Help2-English.zip</li>
 <li>[30]-PS3_SDKDoc-360_01-HTML-English.zip</li>
 <li>[31]-PS3_SDKDoc-360_01-Latest-English.zip</li>
</ul>

 These files are not needed to build toolchain but you can use them with wine to work with your PlayStation 3 DEX 
 
 <ul>
 <li>[84]-SNCPPUToolchainforPlayStation3v360.1.zip</li>
 <li>[85]-ProDGforPlayStation3v360.2.0.exe</li>
 <li>[86]-TargetManagerForPlayStation3v360.2.0.exe</li>
 <li>[87]-TunerforPS3v360.2.0.exe</li>
</ul>


<dt>3) Open a new terminal and go to work directory</dt>
cd /usr/local/cell/work
<dt>4) Run build.sh script for sony</dt>
./build.sh sony

You must overwrite some files choosing A option you can see following output for your reference:

Build Sony's toolchain and SDK 3.60...

Decompressing Sony's SDK 3.60...

replace /usr/local/cell/host-win32/Cg/lib/libcgc_x64.lib? [y]es, [n]o, [A]ll, [N]one, [r]ename: A

Decompressing Sony's SDK 3.60 Samples...

replace /usr/local/cell/info/Bugfix_SDK_e.txt? [y]es, [n]o, [A]ll, [N]one, [r]ename: A

Decompressing Sony's SDK 3.60 Doc if it is available...

replace /usr/local/cell/SDK_doc/en/html/C_and_C++_standard_libraries/algorith.html? [y]es, [n]o, [A]ll, [N]one, [r]ename: A

Decompressing Sony's Toolchain sources...

...
...

a lot of logs lines :P

Toolchain and SDK installed. Have a lot of fun...

Making backup of mk directory

...
...
a few logs more

Patching sdk makefiles to use gcc linker instead of snsys and using new host-osx directory for compiler and tools

patching file sdk.makedef-ppu-gcc.mk

patching file sdk.makedef-prx.mk

patching file sdk.makedef.mk

Creating /usr/local/cell/host-osx/bin directory with custom wine command for tools not availables on toolchain sources

<dt>5) Wait until finish</dt>
</dl>
 
===================
  How do I use it to build homebrew toolchain?
===================

TODO