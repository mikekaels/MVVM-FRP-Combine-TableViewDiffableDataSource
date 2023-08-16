# MVVM-FRP-Combine-TableViewDiffableDataSource

![This is an image](https://ik.imagekit.io/m1ke1magek1t/Github_Readme_/Group%202_bfCKfxw3z.png?updatedAt=1692150533542)

### MVVM-Transform Input Output
```
internal final class StoreVM {
    struct Input {
        ...
    }

    class Output {
        ...
    }

    func transform(_ input: Input, cancellables: inout Set<AnyCancellable>) -> Output {
        ...
    }

}
```

### VC
```
private func bindViewModel() {
		let input = StoreVM.Input(...)
		let output = viewModel.transform(input, cancellables: &cancellables)

		output.$...
			.sink { [weak self] _ in
        ....
			}
			.store(in: &cancellables)
	}
```


## Dependency - Swift Package Manager
- CombineCocoa
- SDWebImage
