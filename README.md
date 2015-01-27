## This is a base for all apps.
製作一個應用最經常用到的最基本的功能和庫的樣本。

### Folder Arrangements 目錄結構:
採用功能目錄，而不用結構目錄。比如不用server、client等等來分目錄。
這樣一般一個目錄就是一個包，方便把功能做成包，像積木一樣來拆分和拼裝。
做包的方法很簡單。可以參看 jk1968:get-quote 這個包。
Use functional folders instead of structural folders. I.e,
例如，管理用戶的功能放在一個目錄。
``` users
	users.html
	users.js

	login
	login.html
	login.js
	...
```
