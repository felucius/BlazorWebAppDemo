using BlazorWebAppDemo.Models;

namespace BlazorWebAppDemo.Services
{
    public class ExerciseProgramServices
    {
        public static List<ExerciseProgram> GetExercisePrograms()
        {
            return CreateExercisePrograms();
        }

        private static List<ExerciseProgram> CreateExercisePrograms()
        {
            return new List<ExerciseProgram>
            {
                new() { Id = 1, Name = "Full Body Workout", Description = "A comprehensive workout targeting all major muscle groups."},
                new(){ Id = 2, Name = "Cardio Blast", Description = "High-intensity cardio exercises to boost your heart rate."},
                new(){ Id = 3, Name = "Strength Training", Description = "Focus on building muscle strength with weightlifting exercises."},
            };
        }
    }
}
