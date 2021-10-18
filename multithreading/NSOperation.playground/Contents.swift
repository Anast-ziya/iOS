import UIKit
import PlaygroundSupport
import Darwin

PlaygroundPage.current.needsIndefiniteExecution = true

/*print(Thread.current)

let operation1 = {
    print("start")
    print(Thread.current)
    print("finish")
}

let queue = OperationQueue()
queue.addOperation(operation1)
 */

// MARK: - NSOperation

print(Thread.current)

var result: String?

let concatOperation = BlockOperation {
    result = "Check the" + " " + "thread"
    print(Thread.current)
}

// MARK: - will be in main thread
//concatOperation.start()
//print(result)

// MARK: - not in main thread
let queue = OperationQueue()
queue.addOperation(concatOperation)

let queue2 = OperationQueue()
queue2.addOperation {
    print("test")
    print(Thread.current)
}

class MyThread: Thread {
    override func main() {
        print("Test my thread")
        print(Thread.current)
    }
}

let myThread = MyThread()
myThread.start()

class OperationA: Operation {
    override func main() {
        print("Test operation A")
        print(Thread.current)
    }
}

let operationA = OperationA()
operationA.start()

// MARK: - Cancel operation

var operationQueue = OperationQueue()

class OperationCancelTest: Operation {
    override func main() {
        if isCancelled {
            print(isCancelled)
            return
        }
        
        print("test 1")
        sleep(1)
        
        if isCancelled {
            print(isCancelled)
            return
        }
        
        print("test 2")
    }
}

func cancelOperationMethod() {
    let cancelOperatuion = OperationCancelTest()
    operationQueue.addOperation(cancelOperatuion)
    cancelOperatuion.cancel()
}

// cancelOperationMethod()

class WaitOperationTest {
    
    private let operationQueue = OperationQueue()
    
    func test() {
        operationQueue.addOperation {
            sleep(1)
            print("test 1")
        }
        operationQueue.addOperation {
            sleep(2)
            print("test 2")
        }
        operationQueue.waitUntilAllOperationsAreFinished()
        operationQueue.addOperation {
            print("test 3")
        }
        operationQueue.addOperation {
            print("test 4")
        }
    }
}

let waitOperationTest = WaitOperationTest()
//waitOperationTest.test()

class WaitOperationTest2 {
    private let operationQueue = OperationQueue()
    
    func test() {
        let operation1 = BlockOperation {
            sleep(1)
            print("test1")
        }
        let operation2 = BlockOperation {
            sleep(2)
            print("test2")
        }
        
        operationQueue.addOperations([operation1, operation2], waitUntilFinished: true)
        
        let operation3 = BlockOperation {
            print("test3")
        }
        
        operationQueue.addOperation(operation3)
    }
}

let waitOperationTest2 = WaitOperationTest2()
waitOperationTest2.test()
