
class Task:
    #Achtung, ID, Counter besser anders
    def __init__(self, description:str, programmer:str, workload:int, is_finished = False, id = []):
        id.append(0)
        self.description = description
        self.workload = workload
        self.programmer = programmer
        self.__is_finished = is_finished
        self.id = len(id)
    
    def is_finished(self):
        return bool(self.__is_finished)
    
    def mark_finished(self):
        self.__is_finished = True
    
    def __str__(self):
        return f"{self.id}: {self.description} ({self.workload} hours), programmer {self.programmer} {"NOT FINISHED" if self.is_finished() == False else "FINISHED"}"


class OrderBook:
    def __init__(self):
        self.__all_orders = []
        self.__programmers = []
        self.__finished_orders = []
        self.__unfinished_orders = []
        self.status = {}

    def finished_orders(self):
        if len(self.__finished_orders) != 0:
            return self.__finished_orders

    def unfinished_orders(self):
        if len(self.__unfinished_orders) != 0:
            return self.__unfinished_orders
    def finish_order(self, id):
        for task in self.__unfinished_orders:
            if task.id == id:
                self.__unfinished_orders.remove(task)
                self.__finished_orders.append(task)

    def programmers(self):
        return self.__programmers
    
    def all_orders(self):
        return self.__all_orders
    
    def mark_finished(self, id:int):
        for task in self.__all_orders:
            if task.id == id:
                task.mark_finished()
                self.finish_order(id)
                return
        raise ValueError()


    def add_order(self, description, programmer, workload):
        name = Task(description, programmer, workload)
        self.__all_orders.append(name)
        self.__unfinished_orders.append(name)
        if programmer not in self.__programmers:
            self.__programmers.append(programmer)
        if programmer not in self.status:
            self.status[programmer] =[name]
        else:
            self.status[programmer].append(name)

    def status_of_programmer(self, programmer: str):
        count_finished = []
        count_unfinished = []
        workload_finished = 0
        workload_unfinished = 0
        if programmer in self.status:
            for task in self.status[programmer]:
                if task.is_finished() == True:
                    count_finished.append(task)
                elif task.is_finished() == False:
                    count_unfinished.append(task)
            if len(count_finished) != 0:
                for task in count_finished:
                    workload_finished += task.workload
            if len(count_unfinished) != 0:     
                for task in count_unfinished:
                    workload_unfinished += task.workload
        else:
            raise ValueError
            
            
        return(len(count_finished),len(count_unfinished),workload_finished,workload_unfinished)
