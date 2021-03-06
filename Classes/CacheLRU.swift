import Foundation

public final class CacheLRU<Key: Hashable, Value> {
    
    private struct CachePayload {
        let key: Key
        let value: Value
    }
    
    private let capacity: Int
    private let list = DoublyLinkedList<CachePayload>()
    private var nodesDict = [Key: DoublyLinkedListNode<CachePayload>]()
    private let semaphore : DispatchSemaphore
    
    fileprivate func lock(){
        semaphore.wait()
    }
    
    fileprivate func unlock(){
        semaphore.signal()
    }
    
    public func getAllValues() -> [Value]{
        var values = [Value]()
        for node in nodesDict {
            values.append(node.value.payload.value)
        }
        return values    
    }
    
    public init(capacity: Int) {
        self.capacity = max(0, capacity)
        self.semaphore = DispatchSemaphore(value: 1)
    }
    
    public func setValue(_ value: Value, for key: Key) -> Value?{
        var retValue : CachePayload?
        self.lock() // 加锁
        let payload = CachePayload(key: key, value: value)
        if let node = nodesDict[key] { // 字典中查找节点
            node.payload = payload
            list.moveToHead(node) // 更新head
        } else {
            let node = list.addHead(payload) // 如果字典中找不到节点, 就加入head中
            nodesDict[key] = node
        }
        
        if list.count > capacity { // 如果超出capacity
            let nodeRemoved = list.removeLast() // 删除最后一个节点
            retValue = nodeRemoved?.payload
            if let key = nodeRemoved?.payload.key {
                nodesDict[key] = nil // 并且把字典中的值社为空
            }
        }
        self.unlock() // 操作完成, 解锁
        return retValue?.value
    }
    
    public func removeValue(for key:Key){
        guard let node = nodesDict[key] else { return }
        self.lock() // 加锁
        list.removeNode(node)
        nodesDict[key] = nil // 并且把字典中的值社为空
        self.unlock() // 操作完成, 解锁
    }
    
    public func getValue(for key: Key) -> Value? {
        guard let node = nodesDict[key] else { return nil }
        list.moveToHead(node)
        return node.payload.value
    }
}
