# SternBrocotTreeSwift

This package is providing rational and intermediate function known as Stern Brocot Tree.
I am very inspired from this article https://begriffs.com/posts/2018-03-20-user-defined-order.html and @begriffs.

## Installation
Install this package from url(https://github.com/yosshi4486/SternBrocotTreeSwift) via swift package manager.

## Registration
To register NSRationalToDataTransformer to CoreData attribute inspector, please follow these steps.
1. Set `NSRationalToDataTransformer` to `Transformer` textfield.
2. Set `NSRational` to `Custom Class` textfield.
3. Set `SternBrocotTreeSwift` to` Module` textfield.
4. Call `NSRationalToDataTransformer.register()` before setting up a persistentContainer.

Setting something to Module, xcdatamodeld/xcdatamodel/contents set combined value `ModuleYouSet.CustomClassYouSet` to its internal `customClass` attribute.


## Contribution
I have not majored math, so my understanding may not be enough. If your notice several misunderstanding of this package, I hope you make issue or pull request. 

