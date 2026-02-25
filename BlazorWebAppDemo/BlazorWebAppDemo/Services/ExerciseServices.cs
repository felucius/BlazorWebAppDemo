using BlazorWebAppDemo.Models;

namespace BlazorWebAppDemo.Services
{
    public class ExerciseServices
    {
        public static List<Exercise> getExercises()
        {
            return CreateExercisesList();
        }

        private static List<Exercise> CreateExercisesList()
        {
            return new List<Exercise>
            {
                new() { Id = 1, Name = "Push-ups", Description = "An exercise for upper body strength." },
                new() { Id = 2, Name = "Squats", Description = "An exercise for lower body strength." },
                new() { Id = 3, Name = "Plank", Description = "An exercise for core strength." },
                new() { Id = 4, Name = "Jumping Jacks", Description = "A cardio exercise to increase heart rate." },
                new() { Id = 5, Name = "Lunges", Description = "An exercise for leg strength and balance." },
                new() { Id = 6, Name = "Burpees", Description = "A full-body exercise that combines strength and cardio." }
            };
        }
    }
}
