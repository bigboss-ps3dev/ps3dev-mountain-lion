====================
 What does this do?
====================

 This program will automatically build and install a compiler and other
 tools official and homebrew used in the creation of official and homebrew 
 software for the Sony PlayStation 3 videogame system using Osx Mountain Lion

====================
 What do i need ?
====================

 You will need a few tool installed before:
  
 1) Your mac with Osx Mountain Lion. All was tested with mac mini late 2012
  
 2) Enable root account. Ref http://support.apple.com/kb/PH11331
  
 3) Install xquartz (x11) Ref http://xquartz.macosforge.org/landing/
  
 4) Install xcode from app store. After install it, open it and install command line tools.       You must go yo Downloads section of Xcode's preferences to do it
  
 5) Install macport https://distfiles.macports.org/MacPorts/MacPorts-2.1.3-10.8-MountainLion.pkg
  
 6) Update macport and enable +universal
 sudo port -v selfupdate
 it will ask you root password, after finish it execute the following line:
 if [ `sysctl -n hw.cpu64bit_capable` -eq 1 ] ; then echo "+universal" | sudo tee -a /opt/local/etc/macports/variants.conf; else echo "not 64bit capable"; fi
  
 7) Install port utils (I installed these, you can have other requirements)  
sudo port install autoconf automake bison flex texinfo ncurses wget libelf zlib libtool git-core gmp openssl mpfr libmpc unrar subversion bzip2
  
 8) Install wine port i use it when some Sony tools are not availables in osx 
 sudo port install wine
 after finish it open a new terminal and run
 winecfg
 it will create basic wine configuration needed later 
 Run these commands from terminal
 $ sudo launchctl load -w /Library/LaunchDaemons/org.freedesktop.dbus-system.plist
 $ launchctl load -w /Library/LaunchAgents/org.freedesktop.dbus-session.plist
  
 9) Create /usr/local/cell and /usr/local/ps3dev folder
 su -
 it will ask you root password
 mkdir -p /usr/local/cell
 mkdir -p /usr/local/ps3dev
  
 I am using my own user and group, use your own configuration as you like
 chown -R bigboss:staff /usr/local/cell
 chown -R bigboss:staff /usr/local/ps3dev
  
 10) Go to /usr/local/cell and get my repository
 mkdir /usr/local/cell/work
 cd /usr/local/cell/work
 git clone https://github.com/bigboss-ps3dev/ps3dev-mountain-lion.git
 
 11) I am using one of the best editor ever made Textnate you can get it from https://github.com/textmate/textmate there are prebuilt binaries 
 
 =========================================
  How do I use it to build Sony toolchain?
 =========================================
 
 
 
 
 =============================================
  How do I use it to build homebrew toolchain?
 =============================================
 
 