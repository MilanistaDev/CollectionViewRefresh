# [iOS10]CollectionViewRefresh

## Summary
We can use UIRefreshControl even CollectionView in iOS10.
So I implemented the sample App by using Swift.

## How to use
There are three data sets of Subway.
If you use UIRefreshControl the data reload at random.
So simple.

```Swift:Swift
// UIRefreshControl 初期化
let refreshControl = UIRefreshControl()


// UIRefreshControl の設定
self.refreshControl.addTarget(self, action: #selector(refreshTrainData),
                                 for: .valueChanged)
self.metroCollectionView.refreshControl = self.refreshControl

// RefreshData
func refreshTrainData() {
       self.refreshControl.endRefreshing()
}
```
