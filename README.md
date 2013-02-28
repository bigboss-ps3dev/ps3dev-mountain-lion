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


<p>You must overwrite some files choosing A option asked with propmt </p>


<dt>5) Wait until finish</dt>
</dl>
 
You can test your new toolchain compiling some sample for example

cd /usr/local/cell/work

You will need profile variables

. ./sce_profile

cd $CELL_SDK/samples/sdk/usbd/usbdesc

make

 
<p>This sample is compiled natively in osx, only when elf is linked it will call  ppu-lv2-prx-fixup wine wrapper.
This tool is used to fix lib stub counts and some other things (you have a source example of this part for elf files and --stub-fix-only option implemented if you like to know what is Sony doing when it is calling this tool from linker, i lose some time making it but prx use other options that i have not implemented yet so for this,  wrapper is enabled)</p>

Making fself for DEX  is using a wine wrapper  if you have a legal native solution for osx share sources for it
 
Sample output:

bigmini:usbdesc bigboss$ pwd

/usr/local/cell/samples/sdk/usbd/usbdesc

bigmini:usbdesc bigboss$ ls

Makefile	main.c		readme_e.txt	readme_j.txt	usbdesc.vcproj

bigmini:usbdesc bigboss$ make

/usr/local/cell/host-osx/ppu/bin/ppu-lv2-gcc -c -g -O2  -std=c99 -W -Wall -Wuninitialized -Wcomment -Wchar-subscripts -Wdeprecated-declarations -Wendif-labels -Wformat=2 -Wformat-extra-args -Wimplicit -Wimport -Winline -Wmissing-braces -Wparentheses -Wpointer-arith -Wredundant-decls -Wreturn-type -Wshadow -Wsign-compare -Wswitch -Wunknown-pragmas -Wunused -Wwrite-strings -Wmain -Wbad-function-cast -Wmissing-declarations -Wnested-externs -Wstrict-prototypes -Wmissing-prototypes  -I/usr/local/cell/target/ppu/include/cell/usbd   -DCELL_DATA_DIR=\"/usr/local/cell/sample_data\" -Wp,-MMD,objs/main.ppu.d,-MT,objs/main.ppu.o -o objs/main.ppu.o main.c

/usr/local/cell/host-osx/ppu/bin/ppu-lv2-g++ -mno-sn-ld  objs/main.ppu.o -lusbd_stub -lsysmodule_stub -lsysutil_stub -o sample.elf

calling ppu-lv2-prx-fixup with --stub-fix-only sample.elf

finished ppu-lv2-prx-fixup process with 0

/usr/local/cell/host-osx/bin/make_fself sample.elf sample.self

calling make_fself with sample.elf sample.self

fixme:msvcrt:MSVCRT__sopen_s : pmode 0x01c0 ignored

finished make_fself process with 0

bigmini:usbdesc bigboss$ ls

Makefile	objs		readme_j.txt	sample.self
main.c		readme_e.txt	sample.elf	usbdesc.vcproj


===================
  How do I use it to build homebrew toolchain?
===================

<dl>
<dt>1) Open a new terminal</dt>

cd /usr/local/cell/work

<dt>2) Run build.sh for ps3dev </dt>
./build.sh ps3dev

<dt>3) Wait until finish ignore errors in last lib NoRSX</dt>
</dl>


===================
How to load samples to PS2 CEX and DEX
===================

TODO