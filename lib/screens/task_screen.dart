import 'package:flutter/material.dart';
import 'package:flutter_poc/isolates/analytics_isolate.dart';
import 'package:flutter_poc/model/task_model.dart';
import 'package:flutter_poc/services/task_service.dart';
import 'package:flutter_poc/utils/responsive.dart';
import 'package:flutter_poc/widgets/task_analytics_card.dart';
import 'package:flutter_poc/widgets/task_card.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> with TickerProviderStateMixin {
  final TaskService service = TaskService();

  List<TaskModel> tasks = [];
  AnalyticsResult? analytics;

  bool loading = false;
  bool processing = false;

  late AnimationController _headerController;

  /// Widget Lifecycle
  /// --------------------------------------
  /// initState() called once
  /// when widget inserted into tree.
  @override
  void initState() {
    super.initState();

    _headerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _headerController.forward();
  }

  /// Called when parent rebuilds
  /// with updated widget data.
  @override
  void didUpdateWidget(covariant TaskScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    debugPrint('TaskScreen updated ${tasks.length}');
  }

  /// Called when widget removed.
  @override
  void dispose() {
    _headerController.dispose();
    super.dispose();
  }

  Future<void> loadTasks() async {
    setState(() {
      loading = true;
    });

    tasks = await service.fetchTasks();

    setState(() {
      loading = false;
    });
  }

  Future<void> runHeavyTask() async {
    /// Prevent analytics before loading tasks
    if (tasks.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please load tasks first")));

      return;
    }

    setState(() {
      processing = true;
    });

    /// Sending task list to isolate
    final result = await generateAnalytics(tasks);

    /// Save analytics response
    analytics = result;

    setState(() {
      processing = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text("Analytics Generated Successfully"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    /// Responsive UI
    final isMobile = Responsive.isMobile(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,

        title: const Text("TaskFlow"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            FadeTransition(
              opacity: Tween<double>(
                begin: 0,
                end: 1,
              ).animate(_headerController), // Explicit animation

              child: const Text(
                "Manage Your Tasks",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              "Track productivity and task analytics",
              style: TextStyle(color: Colors.grey, fontSize: 15),
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: loading ? null : loadTasks,

                    icon: const Icon(Icons.download),

                    label: Text(loading ? "Loading..." : "Load Tasks"),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: processing ? null : runHeavyTask,

                    icon: processing
                        ? const SizedBox(
                            height: 18,
                            width: 18,

                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.analytics),

                    label: Text(processing ? "Processing..." : "Analytics"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),

              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,

                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.1),
                      end: Offset.zero,
                    ).animate(animation),

                    // Implicit animation (no use of controller)
                    child: child,
                  ),
                );
              },

              child: analytics == null
                  ? const SizedBox.shrink()
                  : TaskAnalyticsCard(
                      key: ValueKey(analytics!.productivity),
                      analytics: analytics!,
                    ),
            ),

            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                const Text(
                  "Today's Tasks",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                /// Smooth task count animation
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),

                  child: Text(
                    "${tasks.length} Tasks",

                    key: ValueKey(tasks.length),

                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            /// Loading state
            loading
                ? const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  )
                : tasks.isEmpty
                /// Empty state
                ? Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: const [
                          Icon(Icons.task_alt, size: 80, color: Colors.grey),

                          SizedBox(height: 16),

                          Text(
                            "No Tasks Loaded",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                /// Animated task list
                : Expanded(
                    child: GridView.builder(
                      itemCount: tasks.length,

                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isMobile ? 1 : 2,

                        mainAxisSpacing: isMobile ? 0 : 4,
                        crossAxisSpacing: 16,

                        childAspectRatio: isMobile ? 3.5 : 5,
                      ),

                      itemBuilder: (_, index) {
                        /*
                        Starts lower
                        ↓
                        Moves upward
                        ↓
                        Stops naturally
                         */
                        return TweenAnimationBuilder(
                          duration: Duration(milliseconds: 300 + (index * 50)),

                          // Each item gets a slightly longer delay.
                          tween: Tween<double>(begin: 0, end: 1),

                          builder: (context, value, child) {
                            return Transform.translate(
                              offset: Offset(0, 50 * (1 - value)),

                              // controls vertical movement.
                              child: Opacity(opacity: value, child: child),
                            );
                          },

                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 12),

                            child: TaskCard(
                              task: tasks[index],

                            onComplete: () {
                              setState(() {
                                tasks[index].completed =
                                    !tasks[index].completed;
                              });

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "${tasks[index].title} completed",
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
