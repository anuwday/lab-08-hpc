# Lab 08: Knowledge check

**Answer each question below it, in your own words, in one to three sentences.** Replace the `...` below **Your answer:** with your text. Questions 1 and 3 also ask for saved output, which goes into the directory `results/`.

## 1. Slurm: what jobs have I submitted?

**Your task:** print a history of all your Slurm job submissions *since November 4, 2026*. Format the output to include the job ID, job name, node list, partition, account, user, state, start time, and elapsed time. See the job accounting fields in the [sacct documentation](https://slurm.schedmd.com/sacct.html). You may also ask Claude Code or another LLM for the exact command. 

Redirect the command's output to `results/job-history.txt` and include the file in your submission. Do not worry if some earlier jobs failed or were canceled. The complete history should show your process, including trial and error.

*Hint:* See [Part 1, Step 6](README.md#step-6-check-how-the-tasks-ended) in the README.

**Your answer:** Provide the entire command you used, including all CLI options.

sacct -S 2026-11-04 -X --
format=JobID,JobName,NodeList,Partition,Account,User,State,Start,Elapsed > 
results/job-history.txt

## 2. Slurm: did every array task run at the same time?

You submitted your entire job array with one `sbatch` command, but Slurm scheduled each task separately.

**Your task:** in the job history from Question 1, find the tasks from your most recent completed array run. Compare their start times and elapsed times.

*Hint:* See [Part 1, Step 5](README.md#step-5-watch-the-job-array) in the README.

**Your answer:** Did all tasks in the array start at the same time? Was the elapsed time identical for every task? Explain why or why not.

In 22858000, the tasks didn't start at the same time, and there were gaps between times as each were in groups of 7-8 (approx). Elapsed times weren't completely the same. Due to the GPU being shared with others, I think there is traffic that causes these differences. The next group of times would start a minute later, and so on. These results are affected by how the books aren't all the same size as each other. 

## 3. Slurm: did my job use what it asked for?

Suppose your next job array has 1,000 books instead of 101. Before you submit it, you want to know whether your script asks for too much or too little memory and time.

**Your task:** run `seff` for **one** task of your finished job array, and save its output as `results/seff.txt`.

*Hint:* `seff` takes the ID of one task, such as `4211873_1`. Compare its **Memory Utilized** and **Job Wall-clock time** with `--mem` and `--time` in your `summarize.slurm`.

**Your answer:** How much memory and time did the task use, compared with what your script asked for? What would you change in your script, and why?

The task used 1.33 GB (memory utilized) so memory was over-requested compared to the 16 GB in summarize.slurm. The wall-clock time is 16seconds, meaning the 5-minute time limit was beyond needed. The script asks more than used. If I were to use an array of 1,000 books instead of 101, I might drop the memory to 10GB or 8GB, but still above 1.33 GB. For time, I might shorten it to 3minutes in order to leave room for possible loading/big book. The reason for these choices is because over-requesting can waste resources in the cluster and add to the wait time. However, requesting for too little will have worse consequences, so a safe range is the best option. 

