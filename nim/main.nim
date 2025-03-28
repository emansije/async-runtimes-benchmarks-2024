import std/[cmdline, strutils]
import asyncdispatch

proc asyncTask() {.async.} =
  await sleepAsync(10)

proc main() {.async.} =
  var
    numTasks: int = 100_000
    futures: seq[Future[void]] = @[]
  
  when declared(commandLineParams):
    if paramCount() > 0:
      numTasks = parseInt(commandLineParams()[0])

  for n in 1..numTasks:
    futures.add(asyncTask())
  
  for future in futures:
    await future

when isMainModule:
  asyncCheck(main())
