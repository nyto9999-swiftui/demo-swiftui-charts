# demo-swiftui-charts


## 59k of csv lines store into Disk

- async sequence 4 min 25 sec
- async stream pull-based 3 min 51 sec, best choice with large files
- async stream push-based 4 min 4 sec, but with a high peak at begining memory proccess.

I was planning to use Swift chart which is available for iOS 16 beta, it seems like I have to change my choice, because simulator cannot run concurrenctly.

Therefore, trying to draw chart by using old chart api tmr. sleep sleep
