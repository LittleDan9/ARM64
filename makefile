OBJS = movexamps

ifdef DEBUG
DEBUGFLAGS = -g
else
DEBUGFLAGS = 
endif

%.o: %.s
	as $(DEBUGFLAGS) $< -o $@
HelloWorld: $(OBJS).o
	ld -o $(OBJS) $(OBJS).o
movexamps: $(OBJS).o
	ld -o $(OBJS) $(OBJS).o




