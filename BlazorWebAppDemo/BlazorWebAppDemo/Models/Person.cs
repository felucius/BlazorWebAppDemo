namespace BlazorWebAppDemo.Models
{
    public class Person
    {
        public int Id { get; set; }
        public string Name { get; set; } = string.Empty;
        public int Age { get; set; }
        public List<ExerciseProgram> ExercisePrograms { get; set; } = [];
    }
}
