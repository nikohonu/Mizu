import copy
import random
from itertools import repeat
import sys


class Node:
    def __init__(self, map=None, move=None, parent=None) -> None:
        if map:
            self.map = copy.deepcopy(map)
        else:
            self.map = self.generate_map(int(sys.argv[1]))
        self.move = move
        self.children = []
        self.parent = parent

    def make_move(self):
        count = 0
        column_from = self.map[self.move[0]]
        column_to = self.map[self.move[1]]
        if len(column_from) > 1:
            for i in reversed(range(0, len(column_from))):
                if column_from[i] == column_from[-1]:
                    count += 1
                else:
                    break
        else:
            count = 1
        while count > 0 and len(column_to) < 4:
            count -= 1
            water = column_from.pop()
            column_to.append(water)

    def generate_map(self, bottle_count):
        color_count = bottle_count - 2
        map = []
        for _ in range(bottle_count):
            map.append([])
        need = list(repeat(0, color_count))
        for i in range(color_count):
            for _ in range(4):
                while True:
                    value = random.randint(0, color_count - 1)  # (0, 1, 2) = 3
                    if need[value] < 4:
                        map[i].append(value)
                        need[value] += 1
                        break
        return map

    def get_available_moves_start(self):
        for i in range(len(self.map)):
            if len(self.map[i]) > 0:
                yield i

    def get_available_moves_end(self, start):
        water = self.map[start][-1]
        for i in range(len(self.map)):
            if start != i:
                if len(self.map[i]) == 0:
                    yield i
                elif len(self.map[i]) < 4 and water == self.map[i][-1]:
                    yield i

    def check_win_condition(self):
        win = True
        for i in range(len(self.map)):
            if len(self.map[i]) != 0 and len(self.map[i]) != 4:
                win = False
            if len(self.map[i]) == 4 and len(set(self.map[0])) != 1:
                win = False
        return win

    def print_moves(self):
        moves = []
        node = self
        count = 0
        while node:
            moves.insert(0, (node.move, node.map))
            if node.parent == None:
                print(node.map, ", #", count, sep="")
            node = node.parent
            count += 1
        for m in moves:
            # print(m[0], m[1])
            pass

    def move_count(self):
        moves = []
        node = self
        while node:
            moves.insert(0, node.move)
            node = node.parent
        return len(moves)

    def score(self):
        score = 0
        for i in range(len(self.map)):
            used = list(repeat(0, len(self.map)))
            for water in self.map[i]:
                used[water] += 1
            score += max(used)
        return score


used = []


def check_used(map):
    if map in used:
        return True
    else:
        # print(map)
        used.append(map)
        return False


if __name__ == "__main__":
    tries = 0
    while True:
        result = []
        queue = [Node()]
        i = 0
        while queue:
            i += 1
            node = queue.pop()
            temp_queue = []
            max_temp_queue = 0
            for start in node.get_available_moves_start():
                for end in node.get_available_moves_end(start):
                    sub_node = Node(node.map, (start, end), node)
                    sub_node.make_move()
                    if sub_node.check_win_condition():
                        result.append(sub_node)
                        break
                    if not check_used(sub_node.map):
                        # print(sub_node.map, sub_node.score())
                        max_temp_queue = max(sub_node.score(), max_temp_queue)
                        temp_queue.insert(0, sub_node)
            random.shuffle(temp_queue)
            for q in temp_queue:
                if q.score() == max_temp_queue:
                    queue.insert(0, q)
                    break
            if i % 1000 == 0:
                print(len(queue))
            if i > 5 * 1000:
                break
        result = sorted(result, key=lambda x: x.move_count())
        for r in result[:1]:
            # print(r.move, r.map)
            r.print_moves()
        if result:
            break
        tries += 1
        # print(tries)
