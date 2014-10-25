#ZHStackView

ZHStackView is a simple container view that can hold any UIViews and stack them vertically, you can append, insert and remove a view at any index.It's a kind of simplified UITableView.

## Purpose
We already have UITableView and even more powerful UICollectionView, why do we need this ZHStackView?

In some scenarios, like want to show three stacked buttons, a stack of textFields for onboarding view, using tableView is too heavy, I don't want to write too much code for delegation. 

What I want is just give me an array of UIViews and I give you well managed containerView.

## Preview:
http://youtu.be/1j6_NHcXKT8

## Usage
1: Initialize a stackView

`var stackedView: ZHStackView = ZHStackView()`

2: Set up views
```
sampleViews = []
for _ in 0 ..< 6 {
  sampleViews.append(self.newRandomView())
}
stackedView.setUpViews(sampleViews)
```

3: Added stackView on where you want, that's it!

## Advanced Useage

1: You can optionally provide an array of UIEdgeInsets which is a corresponding insets for views and also a containerInset

`stackedView.setUpViews(sampleViews, viewInsets: [UIEdgeInsetsZero, UIEdgeInsetsZero], containerInset: UIEdgeInsetsZero)`

These insets provide a flexiable way for you to layout views on stackView

2: You can set `alignment` for stack view, this property will affect alignment of views

`stackedView.alignment = .Center`

`stackedView.alignment = .Right`

3: There is a property `var defaultSpacing: CGFloat`, this is a easier way to set spacing between views

4: More and more, will implement `orientation` property for horizontal layout.
