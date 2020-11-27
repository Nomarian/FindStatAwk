
function _dirname_(file){ 
  sub(/\/[^/]+$/,"",file)
  return file
}

function _basename_(_name_,_suffix_) {
 gsub(/^\/|[^/]+\//,"",_name_)
 if (_suffix_) {
   _suffix_	= index(_name_,_suffix_)-1
   _name_	= substr(_name_,1,_suffix_)
 }
 return _name_
}

function makesizes(bytes,array){
 # For quick access, this creates size variables
 split("0 0 0 0",array," ")
 for (i=1;i<=length(array);i++) {
  bytes /= 1024
  if (bytes<1) break
  array[i] = bytes
 }

 sizekb	=array[1]
 sizemb	=array[2]
 sizegb	=array[3]
 sizetb	=array[4]
 # SIZE should be an array!
 # size["bytes"] can then be used
}

function hbytes(i,	x,z){ # returns i in kb,mb,etc
 x=i
 while( (x/=1024) > 1){ i=x; z++ }
 return sprintf("%.4g%sb",i,OrderedStringBytes[z])
}

function hBytes(i,	x,z){ # returns i in KB,MB,GB,etc
 x=i
 while( (x/=1000) > 1){ i=x; z++ }
 return sprintf( "%.4g%sB", i, toupper(OrderedStringBytes[z]) )
}

function mkdate(string,array,epoch, a){
 array[""]=string
 array["epoch"]=epoch
 split(string,a,/[-:. ]/)
 for(i in dates) array[dates[i]]=a[i]
}

BEGIN {
 split("k m g t p",OrderedStringBytes)
 split("year month day hour minute seconds nanoseconds",dates)
 split("jan feb mar apr may jun jul aug sep oct nov dec",months)
 split("Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec",Months)

 FS="\r"
# FS="\x30"
# RS="\x00"
}

{ # Formats translater
 operms		= $1 #0755 

 huperms	= $2 #-rwxrwxrwx
 humanperms	= $2 # synonym
 permission	= $2
 permissions	= $2
 
 blocks		= $3
 ByteBlocks	= $4
 DeviceNum	= $5
 DeviceHex	= $6
 rawhex		= $7

 filetype	= $8 # regular file|directory|character special file
 type		= $8 # block special file|symbolic link|regular empty file

 # Group ID
 gid		= $9 
 groupid	= $9 # (Numeric)

 # Group name
 group	= $10
 groupname	= $10
 gname	= $10

 hardlinks	= $11
 inode		= $12
 mount		= $13
 file		= $14
 FileName	= $15 # outputs realpath for symbolic links
 optimalIO	= $16
 sizeb		= $17
 majordevicetype	= $18
 minordevicetype	= $19

 # User ID
 uid		= $20 # numeric
 uname		= $21 # name
 username	= $21 # name
 owner		= $21 # name

 # Dates!
 hbirth		= $22
 obirth		= $23
 mkdate(hbirth,birth,obirth)
 
 haccess	= $24
 oaccess	= $25
 mkdate(haccess,access,oaccess)
 
 hmod		= $26
 omod		= $27
 mkdate(hmod,mod,omod)
 
 hchange	= $28
 ochange	= $29
 mkdate(hchange,change,ochange)
 
 inodetotal	= $30
 maxfilelength	= $31
 fublocksize	= $32

 for(i=1;i<=NF;i++) all[i]=$i
 $0=file # for quick searching with // or $0 ~ ""

 # file be filename?
 # path is fullpath?
 # dir is the directory? as in ../
 # dirname is the directory name?
 
 makesizes(sizeb)
 filename	= _basename_(file)
 ext = ""

 if (filetype == "directory") {
	dirname = file # get ../ not current file!
  } else {
	dirname	= _dirname_(file)
 }

 if (filetype == "regular file") {
	ext=filename
	# can't use match
	if ( sub(/(\.[^.]+)$/,"\1",ext) ) {
	  ext = substr(filename,length(ext)+1)
	 } else {
	  ext=""
	}
 }
}
