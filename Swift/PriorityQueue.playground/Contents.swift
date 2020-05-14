import UIKit

struct PriorityQeueue<Element> {
    
    
    fileprivate var _elements = [Element]()
    
    private let _hasHigherPriority: (Element, Element) -> Bool
    private let _isEqual: (Element, Element) -> Bool
    
    init(hasHigherPriority: @escaping (Element, Element) -> Bool, isEqual: @escaping (Element, Element) -> Bool) {
        _hasHigherPriority = hasHigherPriority
        _isEqual = isEqual
    }
    
    // 获取优先级最高的元素
    func peek() -> Element? {
        return _elements.first
    }
    
    /*
     有元素进入队列时，首先将元素添加到数组_elements的末尾，相当于在堆树的末尾又添加了一个节点，这时需要根据这个节点的优先级和其父节点的优先级调整数组。因为在添加元素之前的树结构已经满足最大堆的要求，所以现在只需要关注最后一个节点和它的父节点的优先级，如果最后一个节点的优先级较高，则将最后一个节点和它的父节点进行调整。以此类推，一直向上调整到树的顶端。
     */
    
    mutating func enqueue(_ element: Element) {
        _elements.append(element)
        bubbleToHigherPriority(_elements.count - 1);
    }
    
    // 从下标为 initialUnbalancedIndex 处向高的优先级处调整元素
    private mutating func bubbleToHigherPriority(_ initialUnbalancedIndex: Int) {
        precondition(initialUnbalancedIndex >= 0)
        precondition(initialUnbalancedIndex < _elements.count)
        
        var unbalancedIndex = initialUnbalancedIndex
        
        while unbalancedIndex > 0 {
            let parentIndex = (unbalancedIndex - 1) / 2     //当前父节点
            guard _hasHigherPriority(_elements[unbalancedIndex], _elements[parentIndex]) else { break }
            _elements.swapAt(unbalancedIndex, parentIndex)
            unbalancedIndex = parentIndex
        }
    }
    
    // 向低优先级调整元素
    private mutating func bubbleToLowerPriority(_ initialUnbalanceIndex: Int) {
        precondition(initialUnbalanceIndex >= 0)
        precondition(initialUnbalanceIndex < _elements.count)
        
        var unbalanceIndex = initialUnbalanceIndex
        while true {
            let leftChildIndex = unbalanceIndex * 2 + 1
            let rightChildIndex = unbalanceIndex * 2 + 2
            
            var highestPriorityIndex = unbalanceIndex
            
            if leftChildIndex < _elements.count && _hasHigherPriority(_elements[leftChildIndex], _elements[highestPriorityIndex]) {
                highestPriorityIndex = leftChildIndex
            }
            
            if rightChildIndex < _elements.count && _hasHigherPriority(_elements[rightChildIndex], _elements[highestPriorityIndex]) {
                highestPriorityIndex = rightChildIndex
            }
            
            // 原地未动, 符合队列，直接退出，不做处理
            guard highestPriorityIndex != unbalanceIndex else { break }
            
            // 否则，交换两个位置的值
            _elements.swapAt(highestPriorityIndex, unbalanceIndex)
            
            unbalanceIndex = highestPriorityIndex
        }
    }
    
    // 优先级最高的元素出队列
    mutating func dequeue() -> Element? {
        guard  let front = peek() else {
            return nil
        }
        
        removeAt(0)
        
        return front
    }
    
    // 移除指定索引的元素
    private mutating func removeAt(_ index: Int) {
        let removingLast = index == _elements.count - 1
        if !removingLast {
            // 如果移除的元素不是最后一个，将此元素和最后一个元素进行交换
            _elements.swapAt(index, _elements.count - 1)
        }
        
        // 移除最后一个元素
        _elements.popLast()
        
        // 将交换的元素进行整理，上浮或下沉
        if !removingLast {
            bubbleToHigherPriority(index)
            bubbleToLowerPriority(index)
        }
    }
    
    // 移除任意一个元素
    mutating func remove(_ element: Element) {
        for i in 0 ..< _elements.count {
            if _isEqual(_elements[i], element) {
                removeAt(i)
                return
            }
        }
    }
}


let maxPriorityQueue = PriorityQeueue<Int>(hasHigherPriority: >, isEqual: ==)

