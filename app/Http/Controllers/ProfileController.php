<?php

namespace App\Http\Controllers;

use App\Models\User;
use Dedoc\Scramble\Attributes\Endpoint;
use Dedoc\Scramble\Attributes\Group;
use Illuminate\Http\Request;

#[Group(
    name: 'Profile Management',
    description: 'Manage user profiles, inspect account details, and update or remove profile records.',
)]
class ProfileController extends Controller
{
    #[Endpoint(
        title: 'List profiles',
        description: 'Return all user profile records available to the authenticated request context.',
    )]
    public function index()
    {
        $users = User::all();
        return response()->json(['data' => $users, 'status' => 'success']);
    }

    #[Endpoint(
        title: 'Get profile details',
        description: 'Fetch a specific user profile by identifier and return the associated account information.',
    )]
    public function show(User $user)
    {
        $user = User::where('id', $user->id)->first();

        if (!$user) {
            return response()->json(['message' => 'User not found!'], 404);
        }

        return response()->json(['data' => $user, 'status' => 'success']);
    }

    #[Endpoint(
        title: 'Update a profile',
        description: 'Update the user name, email, and optional password while validating uniqueness and confirmation rules.',
    )]
    public function update(Request $request, User $user)
    {
        $validate = $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|email|unique:users,email,' . $user->id,
            'password' => 'nullable|string|min:8|confirmed',
        ]);

        $user->update($validate);

        return response()->json(['data' => $user, 'status' => 'success']);
    }

    #[Endpoint(
        title: 'Delete a profile',
        description: 'Remove a user profile record permanently from the system.',
    )]
    public function destroy(User $user)
    {
        $user->delete();
        return response()->json(['message' => 'User deleted successfully!'], 200);
    }
}
