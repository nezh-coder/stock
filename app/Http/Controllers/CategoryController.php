<?php
namespace App\Http\Controllers;
use App\Models\Category;
use Illuminate\Http\Request;
use Maatwebsite\Excel\Facades\Excel;
use App\Imports\CategoriesImport;
class CategoryController extends Controller
{
    public function import1()
{
    return view('categories.import1');
}

    public function import(Request $request)
{
    $request->validate([
        'file' => 'required|mimes:xlsx,csv'
    ]);

    Excel::import(new CategoriesImport, $request->file('file'));

   return redirect()->route('categories.index')
                     ->with('success', 'Catégories importées avec succès');
}
    public function index(Request $request)
    {
          $query = Category::withCount('products');
        ////$query = Category::query();

        // Search by name
        if ($request->has('search') && !empty($request->search)) {
            $query->where('name', 'like', '%' . $request->search . '%');
        }
        $categories = $query->paginate(15);
        return view('categories.index', compact('categories'));
    }

    public function create()
    {
        return view('categories.create');
    }

    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'description' => 'nullable|string|max:255',
        ]);

        Category::create($request->all());
        return redirect()->route('categories.index')->with('success', 'Category added');
    }

    public function edit(Category $category)
    {
        return view('categories.edit', compact('category'));
    }

    public function update(Request $request, Category $category)
    {
        $request->validate([
            'name' => 'required|string|max:255',
        ]);

        $category->update($request->all());
        return redirect()->route('categories.index')->with('success', 'Category updated');
    }

    public function destroy(Category $category)
    {
        $category->delete();
        return redirect()->route('categories.index')->with('success', 'Category deleted');
    }
    public function store_live(Request $request)
{
    $request->validate([
        'name' => 'required|string|max:255',
    ]);

    $category = Category::create([
        'name' => $request->name,
    ]);

    return response()->json([
        'id' => $category->id,
        'name' => $category->name,
    ]);
}
public function show(Category $category)
{
    // Optionally redirect somewhere, or return a view
    return redirect()->route('categories.index');
}

}
?>