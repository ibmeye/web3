### （一）基础语法

**(1)包裹基础类型**

`struct`可以创建一个类型，用来包裹一些基础的类型。

比如，下面的`Todo`结构体，就包含两个基础类型，一个是`string`类型，用来表示下一步要做的事情，另一个是`bool`的类型，用来表示是否已经做完。

```solidity
struct Todo {
    string text;
    bool completed;
}
```

当然，除了基础类型，还可以包裹结构体类型。

**(2)一些基础的用法**

基础的用法包括定义结构体，创建结构体数组，初始化结构体并放入到结构体数组中，然后更新结构体数组中的内容。

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Todos {
	// 定义结构体
    struct Todo {
        string text;
        bool completed;
    }

    // 创建一个结构体数组
    Todo[] public todos;

    function create(string calldata _text) public {
        // 3种方式来初始化
        // 1. 依次给出所有的值
        todos.push(Todo(_text, false));

        // 2. 给出指定字段的值，没有给的就是默认值
        todos.push(Todo({text: _text, completed: false}));

        // 3.创建一个memory类型的变量，然后更新它，最后推入到结构体数组
        Todo memory todo;
        todo.text = _text;
        // todo.completed 被初始化为 false
        
        todos.push(todo);
    }

    // 注意这里`Todo storage`中，使用`storage`修饰是非常有必要的，如果使用`memory`，则会引来不必要的拷贝
    function get(uint _index) public view returns (string memory text, bool completed) {
        Todo storage todo = todos[_index];
        return (todo.text, todo.completed);
    }

    // 更新内容text
    function updateText(uint _index, string calldata _text) public {
        Todo storage todo = todos[_index];
        todo.text = _text;
    }

    // 更新结果completed
    function toggleCompleted(uint _index) public {
        Todo storage todo = todos[_index];
        todo.completed = !todo.completed;
    }
}
```

**(3)结构体可以被定义在合约的外边，这样其他合约就可以引用这个结构体了**

比如，我们首先在一个文件夹中，定义一个结构体：

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;
// This is saved 'StructDeclaration.sol'

struct Todo {
    string text;
    bool completed;
}
```

然后，其他合约就可以通过`import`以及相对路径来进行引用了。

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./StructDeclaration.sol";

contract Todos {
    // An array of 'Todo' structs
    Todo[] public todos;
}
```

### （二）案例分析

在房产项目中使用`Counters.Counter`结构体来完成自增计数器的功能

**(1)自增计数器的实现**

在oepnzeppelin项目中，我们使用到了一个`Counters.sol`的计数器。

这个`Counters.sol`的代码如下：

```solidity
// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts v4.4.1 (utils/Counters.sol)

pragma solidity ^0.8.0;

/**
 * @title Counters
 * @author Matt Condon (@shrugs)
 * @dev Provides counters that can only be incremented, decremented or reset. This can be used e.g. to track the number
 * of elements in a mapping, issuing ERC721 ids, or counting request ids.
 *
 * Include with `using Counters for Counters.Counter;`
 */
library Counters {
    struct Counter {
        // This variable should never be directly accessed by users of the library: interactions must be restricted to
        // the library's function. As of Solidity v0.5.2, this cannot be enforced, though there is a proposal to add
        // this feature: see https://github.com/ethereum/solidity/issues/4637
        uint256 _value; // default: 0
    }

    function current(Counter storage counter) internal view returns (uint256) {
        return counter._value;
    }

    function increment(Counter storage counter) internal {
        unchecked {
            counter._value += 1;
        }
    }

    function decrement(Counter storage counter) internal {
        uint256 value = counter._value;
        require(value > 0, "Counter: decrement overflow");
        unchecked {
            counter._value = value - 1;
        }
    }

    function reset(Counter storage counter) internal {
        counter._value = 0;
    }
}
```

上面介绍的这个结构体`struct Counter`只包含一个单独的基础类型的变量`_value`，之所以不用单独的变量，而是使用结构体。我认为主要有两点原因：

1. 在形式上防止用户直接操作计数的变量，虽然用户还是可以直接操作，但是由于是结构体方式，用户直接修改起来不会那么肆无忌惮。
2. 有利于后期的扩展，虽然现在只包裹一个变量，但是以后可以让结构体包含更多的变量，以及针对该结构体实现更多的方法。如果直接以基础变量的形式展示给用户，这样后续扩展性将会非常弱。

**(2)自增计数器的使用**

在房产项目中，我们就是用上面的这个结构体来维护一个自增的id序列的。

其主要用法如下：

```solidity
...
using Counters for Counters.Counter;

// 定义结构体
Counters.Counter private _tokenIds;

// 铸币交易或者挖矿交易
function mint(string memory tokenURI) public returns (uint256) {
	// 让_tokenIds自增
	_tokenIds.increment();
	
	// 获得当前_tokenIds的值
	uint256 tokenId = _tokenIds.current();
	
	// 将新生成的tokenId授权给调用该合约方法的铸币者（目前可以不用理解这句话，房产项目上会详细解释）
	_mint(msg.sender, newItemId);
	
	// 将新生成的tokenId与尾部传入的tokenURI进行绑定（目前可以不用理解这句话，房产项目上会详细解释）
	_setTokenURI(tokenId, tokenURI);
}
...
```

总结一下，就是我们通过在合约外定义结构体`Counters.Counter`，并在其他合约引入结构体以及结构体对应的方法`using Counters for Counters.Counter`，最后就将自增器的逻辑从业务合约分离了出去，做到了高内聚低耦合。

**(3)`using Counters for Counters.Counter`的作用**

这句话的作用就是将`Counters`库中的方法，绑定给结构体`Counters.Counter`使用。

举个例子，通过这句话，我们就可以直接使用`Counters.Counter`的来调用`increment()`方法。相当于我们使用`increment`方法并把调用者本身传入方法中作为第一个参数。
