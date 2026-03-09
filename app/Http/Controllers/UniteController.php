<?php
namespace App\Http\Controllers;
use App\Models\Unite;
use Illuminate\Http\Request;
use Maatwebsite\Excel\Facades\Excel;
use App\Imports\unitesImport;
class UniteController extends Controller
{
    public function import1()
{
    return view('unites.import1');
}

    public function import(Request $request)
{
    $request->validate([
        'file' => 'required|mimes:xlsx,csv'
    ]);

    Excel::import(new unitesImport, $request->file('file'));

   return redirect()->route('unites.index')
                     ->with('success', 'Unités importées avec succès');
}
    public function index(Request $request)
    {
          $query = Unite::withCount('products');
        ////$query = Unite::query();

        // Search by name
        if ($request->has('search') && !empty($request->search)) {
            $query->where('name', 'like', '%' . $request->search . '%');
        }
        $unites = $query->paginate(15);
        return view('unites.index', compact('unites'));
    }

    public function create()
    {
        return view('unites.create');
    }

    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'description' => 'nullable|string|max:255',
        ]);

        Unite::create($request->all());
        return redirect()->route('unites.index')->with('success', 'Unite added');
    }

    public function edit(Unite $Unite)
    {
        return view('unites.edit', compact('Unite'));
    }

    public function update(Request $request, Unite $Unite)
    {
        $request->validate([
            'name' => 'required|string|max:255',
        ]);

        $Unite->update($request->all());
        return redirect()->route('unites.index')->with('success', 'Unite updated');
    }

    public function destroy(Unite $Unite)
    {
        $Unite->delete();
        return redirect()->route('unites.index')->with('success', 'Unite deleted');
    }
    public function store_live(Request $request)
{
    $request->validate([
        'name' => 'required|string|max:255',
    ]);

    $Unite = Unite::create([
        'name' => $request->name,
    ]);

    return response()->json([
        'id' => $Unite->id,
        'name' => $Unite->name,
    ]);
}
public function show(Unite $Unite)
{
    // Optionally redirect somewhere, or return a view
    return redirect()->route('unites.index');
}

}
?>