# GlobalToJSON-Compact
This package offers a utility to load a Global into JSON object and to create a    
Global from this type of JSON object. ***Compact*** refers to the structure created.    
Globals nodes are included with data for a fast data load.
But also the related code is quite compact.    

![](https://raw.githubusercontent.com/rcemper/GlobalToJSON-Compact/master/Globals.png)    

## Prerequisites
Make sure you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [Docker desktop](https://www.docker.com/products/docker-desktop) installed.
## Installation 
Clone/git pull the repo into any local directory
```
git clone https://github.com/rcemper/GlobalToJSON-Compact.git 
```
Run the IRIS container with your project: 
```
docker-compose up -d --build
```
## How to Test it
This is the pre-loaded Global **^dc.MultiD** for testing.    
![](https://raw.githubusercontent.com/rcemper/GlobalToJSON-Compact/master/Global.JPG)

Open IRIS terminal 
```
$ docker-compose exec iris iris session iris
USER>

USER>; generate JSON object from Global

USER>set json=##class(dc.GblToJSON.C).do("^dc.MultiD")

USER>zw json
json={"gbl":["^dc.MultiD=5","^dc.MultiD(1)=$lb(\"Braam,Ted Q.\",51353)","^dc.MultiD(1,\"
mJSON\")=\"{}\"","^dc.MultiD(2)=$lb(\"Klingman,Uma C.\",62459)","^dc.MultiD(2,2,\"Multi\
",\"a\")=1","^dc.MultiD(2,2,\"Multi\",\"rob\",1)=\"rcc\"","^dc.MultiD(2,2,\"Multi\",\"ro
b\",2)=2222","^dc.MultiD(2,\"Multi\",\"a\")=1","^dc.MultiD(2,\"Multi\",\"rob\",1)=\"rcc\
"","^dc.MultiD(2,\"Multi\",\"rob\",2)=2222","^dc.MultiD(2,\"mJSON\")=\"{\"\"A\"\":\"\"ah
ahah\"\",\"\"Rob\"\":\"\"VIP\"\",\"\"Rob2\"\":1111,\"\"Rob3\"\":true}\"","^dc.MultiD(3)=
$lb(\"Goldman,Kenny H.\",45831)","^dc.MultiD(3,\"mJSON\")=\"{}\"","^dc.MultiD(4)=$lb(\"\
",\"\")","^dc.MultiD(4,\"mJSON\")=\"{\"\"rcc\"\":122}\"","^dc.MultiD(5)=$lb(\"\",\"\")",
"^dc.MultiD(5,\"mJSON\")=\"{}\""]}  ; <DYNAMIC OBJECT>

USER>; this is rather hard to read and follow

USER>write $$Do^ZPretty(json)
{
  "gbl":[
    "^dc.MultiD=5",
    "^dc.MultiD(1)=$lb(\"Braam,Ted Q.\",51353)",
    "^dc.MultiD(1,\"mJSON\")=\"{}\"",
    "^dc.MultiD(2)=$lb(\"Klingman,Uma C.\",62459)",
    "^dc.MultiD(2,2,\"Multi\",\"a\")=1",
    "^dc.MultiD(2,2,\"Multi\",\"rob\",1)=\"rcc\"",
    "^dc.MultiD(2,2,\"Multi\",\"rob\",2)=2222",
    "^dc.MultiD(2,\"Multi\",\"a\")=1",
    "^dc.MultiD(2,\"Multi\",\"rob\",1)=\"rcc\"",
    "^dc.MultiD(2,\"Multi\",\"rob\",2)=2222",
    "^dc.MultiD(2,\"mJSON\")=\"{\"\"A\"\":\"\"ahahah\"\",\"\"Rob\"\":\"\"VIP\"\",\"\"Rob2\"\":1111,\"\"Rob3\"\":true}\"",
    "^dc.MultiD(3)=$lb(\"Goldman,Kenny H.\",45831)",
    "^dc.MultiD(3,\"mJSON\")=\"{}\"",
    "^dc.MultiD(4)=$lb(\"\",\"\")",
    "^dc.MultiD(4,\"mJSON\")=\"{\"\"rcc\"\":122}\"",
    "^dc.MultiD(5)=$lb(\"\",\"\")",
    "^dc.MultiD(5,\"mJSON\")=\"{}\""
  ]
}
```

Now we want to verify the load function.  
First we make a copy of our source and then delete the source   
After the load operation the source Global is completely restored    
```
USER>merge ^keep=^dc.MultiD  

USER>kill ^dc.MultiD

USER>set sc=##class(dc.GblToJSON.C).load(json)

USER>zw sc
sc=1

USER>zw ^dc.MultiD
^dc.MultiD=5
^dc.MultiD(1)=$lb("Braam,Ted Q.",51353)
^dc.MultiD(1,"mJSON")="{}"
^dc.MultiD(2)=$lb("Klingman,Uma C.",62459)
^dc.MultiD(2,2,"Multi","a")=1
^dc.MultiD(2,2,"Multi","rob",1)="rcc"
^dc.MultiD(2,2,"Multi","rob",2)=2222
^dc.MultiD(2,"Multi","a")=1
^dc.MultiD(2,"Multi","rob",1)="rcc"
^dc.MultiD(2,"Multi","rob",2)=2222
^dc.MultiD(2,"mJSON")="{""A"":""ahahah"",""Rob"":""VIP"",""Rob2"":1111,""Rob3"":true}"
^dc.MultiD(3)=$lb("Goldman,Kenny H.",45831)
^dc.MultiD(3,"mJSON")="{}"
^dc.MultiD(4)=$lb("","")
^dc.MultiD(4,"mJSON")="{""rcc"":122}"
^dc.MultiD(5)=$lb("","")
^dc.MultiD(5,"mJSON")="{}"

USER>
```
### New Version 0.1.0 ###
The new version takes care of large Globals that may break your available memory.  
So the JSON Object is exported to a file.  
```
USER>write ##class(dc.GblToJSON.CX).export("^dc.MultiD")
File gbl.json created
```
And the related loader creates the Global 
```
USER>write ##class(dc.GblToJSON.CX).import()
Global ^dc.MultiD loaded
```

**q.a.d.**   

### Code Quality  
![CodeQuality](https://raw.githubusercontent.com/rcemper/GlobalToJSON-Compact/master/CodeQuality.JPG)

[Video](https://youtu.be/8Fz2537FHzc)    

[Online Demo Terminal](https://gbl-to-json-c.demo.community.intersystems.com/terminal/)      
[Online Demo SMP](https://gbl-to-json-c.demo.community.intersystems.com/csp/sys/%25CSP.Portal.Home.zen)   

[Article in DC](https://community.intersystems.com/post/globaltojson-compact)
