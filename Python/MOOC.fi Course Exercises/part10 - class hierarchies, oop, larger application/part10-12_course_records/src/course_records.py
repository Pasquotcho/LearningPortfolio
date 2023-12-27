class Course:
    def __init__(self, course:str, grade:int, credits:int):
        self.course = course    
        self.grade = grade
        self.credits = credits

    def __str__(self):
        return f"{self.course} ({self.credits} cr) grade {self.grade}"




class Courses:

    
    def __init__(self):
        self.courses = {}
    def execute(self):
        print("1 add course\n2 get course data\n3 statistics\n0 exit")
        while True:
            print()
            userinput = input("command: ")
            if userinput == "1":
                self.add_course()
            elif userinput == "2":
                self.get_course()
            elif userinput == "3":
                self.stats()
            elif userinput == "0":
                break
            else:
                continue

    def add_course(self):
        course = str(input("course "))
        coursename = course
        grade = int(input("grade "))
        credits = int(input("credits "))
        if coursename not in  self.courses:
            course = Course(course, grade, credits)
            self.courses[coursename] = course

        elif self.courses[coursename].grade < grade:
              self.courses[coursename].grade = grade
            

    def get_course(self):
        course = input("course ")
        if len(self.courses) != 0:
            if course in self.courses:
                print(self.courses[course])
            else:
                print("no entry for this course")


    def stats(self):
        how_many_courses = 0
        all_credits = 0
        grades_sum = 0
        grades = {1:0, 2:0, 3:0, 4:0, 5:0}
        for course in self.courses.values():
            how_many_courses += 1
            all_credits += course.credits
            grades_sum += course.grade
            grades[course.grade] += 1
        mean = grades_sum / how_many_courses
        print(f"{how_many_courses} completed courses, a total of {all_credits} credits")
        print(f"mean {format(mean, '.1f')}")
        print("grade distribution")
        print(f"5: {'x' * grades[5]}")
        print(f"4: {'x' * grades[4]}")
        print(f"3: {'x' * grades[3]}")
        print(f"2: {'x' * grades[2]}")
        print(f"1: {'x' * grades[1]}")

play = Courses()
play.execute()